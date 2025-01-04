module [territory, territories]

Intersection : { x : U64, y : U64 }

Stone : [White, Black, None]

Territory : {
    owner : Stone,
    territory : Set Intersection,
}

Territories : {
    black : Set Intersection,
    white : Set Intersection,
    none : Set Intersection,
}

Board : {
    rows : List (List Stone),
    width : U64,
    height : U64,
}

parse : Str -> Result Board [BoardWasEmpty, BoardWasNotRectangular, InvalidChar U8]
parse = \board_str ->
    if board_str == "" then
        Err BoardWasEmpty
        else

    rows =
        board_str
            |> Str.toUtf8
            |> List.splitOn '\n'
            |> List.mapTry? \row ->
                row
                |> List.mapTry \char ->
                    when char is
                        'B' -> Ok Black
                        'W' -> Ok White
                        ' ' -> Ok None
                        _ -> Err (InvalidChar char)
    row_widths = rows |> List.map List.len
    width = row_widths |> List.max |> Result.withDefault 0
    if row_widths |> List.any \w -> w != width then
        Err BoardWasNotRectangular
    else
        height = List.len rows
        Ok { rows, width, height }

get_stone : Board, Intersection -> Stone
get_stone = \board, { x, y } ->
    board.rows |> List.get y |> Result.withDefault [] |> List.get x |> Result.withDefault None

territory : Str, Intersection -> Result Territory [OutOfBounds, BoardWasEmpty, BoardWasNotRectangular, InvalidChar U8]
territory = \board_str, intersection ->
    board = parse? board_str
    if intersection.x >= board.width || intersection.y >= board.height then
        Err OutOfBounds
        else

    Ok (search_territory board intersection)

search_territory : Board, Intersection -> Territory
search_territory = \board, intersection ->
    help = \to_visit, visited, surrounding_stones ->
        when to_visit is
            [] -> { visited, surrounding_stones }
            [visiting, .. as rest_to_visit] ->
                if visited |> Set.contains visiting then
                    help rest_to_visit visited surrounding_stones
                    else

                stone = board |> get_stone visiting
                when stone is
                    Black | White ->
                        new_surrounding_stones = surrounding_stones |> Set.insert stone
                        help rest_to_visit visited new_surrounding_stones

                    None ->
                        neighbors =
                            [
                                { x: visiting.x |> Num.subSaturated 1, y: visiting.y },
                                { x: visiting.x + 1, y: visiting.y },
                                { x: visiting.x, y: visiting.y |> Num.subSaturated 1 },
                                { x: visiting.x, y: visiting.y + 1 },
                            ]
                            |> List.dropIf \neighbor ->
                                neighbor.x >= board.width || neighbor.y >= board.height || neighbor == visiting
                        new_to_visit = rest_to_visit |> List.concat neighbors
                        new_visited = visited |> Set.insert visiting
                        help new_to_visit new_visited surrounding_stones
    search_result = help [intersection] (Set.empty {}) (Set.empty {})
    if search_result.visited |> Set.isEmpty then
        { owner: None, territory: Set.empty {} }
    else
        owner =
            if search_result.surrounding_stones == Set.single Black then
                Black
            else if search_result.surrounding_stones == Set.single White then
                White
            else
                None
        { owner, territory: search_result.visited }

territories : Str -> Result Territories [BoardWasEmpty, BoardWasNotRectangular, InvalidChar U8]
territories = \board_str ->
    board = parse? board_str
    board.rows
    |> List.mapWithIndex \row, y ->
        row
        |> List.mapWithIndex \stone, x ->
            if stone == None then
                [{ x, y }]
            else
                []
        |> List.join
    |> List.join
    |> List.walk { black: Set.empty {}, white: Set.empty {}, none: Set.empty {} } \state, intersection ->
        if state.black |> Set.contains intersection || state.white |> Set.contains intersection || state.none |> Set.contains intersection then
            state
        else
            new_territory = search_territory board intersection
            when new_territory.owner is
                Black -> { black: state.black |> Set.union new_territory.territory, white: state.white, none: state.none }
                White -> { black: state.black, white: state.white |> Set.union new_territory.territory, none: state.none }
                None -> { black: state.black, white: state.white, none: state.none |> Set.union new_territory.territory }
    |> Ok