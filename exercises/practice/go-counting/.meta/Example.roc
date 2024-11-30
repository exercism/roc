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
parse = \boardStr ->
    if boardStr == "" then
        Err BoardWasEmpty
        else

    rows =
        boardStr
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
    rowWidths = rows |> List.map List.len
    width = rowWidths |> List.max |> Result.withDefault 0
    if rowWidths |> List.any \w -> w != width then
        Err BoardWasNotRectangular
    else
        height = List.len rows
        Ok { rows, width, height }

getStone : Board, Intersection -> Stone
getStone = \board, { x, y } ->
    board.rows |> List.get y |> Result.withDefault [] |> List.get x |> Result.withDefault None

territory : Str, Intersection -> Result Territory [OutOfBounds, BoardWasEmpty, BoardWasNotRectangular, InvalidChar U8]
territory = \boardStr, intersection ->
    board = parse? boardStr
    if intersection.x >= board.width || intersection.y >= board.height then
        Err OutOfBounds
        else

    Ok (searchTerritory board intersection)

searchTerritory : Board, Intersection -> Territory
searchTerritory = \board, intersection ->
    help = \toVisit, visited, surroundingStones ->
        when toVisit is
            [] -> { visited, surroundingStones }
            [visiting, .. as restToVisit] ->
                if visited |> Set.contains visiting then
                    help restToVisit visited surroundingStones
                    else

                stone = board |> getStone visiting
                when stone is
                    Black | White ->
                        newSurroundingStones = surroundingStones |> Set.insert stone
                        help restToVisit visited newSurroundingStones

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
                        newToVisit = restToVisit |> List.concat neighbors
                        newVisited = visited |> Set.insert visiting
                        help newToVisit newVisited surroundingStones
    searchResult = help [intersection] (Set.empty {}) (Set.empty {})
    if searchResult.visited |> Set.isEmpty then
        { owner: None, territory: Set.empty {} }
    else
        owner =
            if searchResult.surroundingStones == Set.single Black then
                Black
            else if searchResult.surroundingStones == Set.single White then
                White
            else
                None
        { owner, territory: searchResult.visited }

territories : Str -> Result Territories [BoardWasEmpty, BoardWasNotRectangular, InvalidChar U8]
territories = \boardStr ->
    board = parse? boardStr
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
            newTerritory = searchTerritory board intersection
            when newTerritory.owner is
                Black -> { black: state.black |> Set.union newTerritory.territory, white: state.white, none: state.none }
                White -> { black: state.black, white: state.white |> Set.union newTerritory.territory, none: state.none }
                None -> { black: state.black, white: state.white, none: state.none |> Set.union newTerritory.territory }
    |> Ok
