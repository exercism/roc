module [winner]

Cell : [StoneO, StoneX, Empty]
Board : List (List Cell)
Position : { x : U64, y : U64 }

## Parse a string to a Board
parse : Str -> Result Board [InvalidCharacter U8]
parse = \board_str ->
    board_str
    |> Str.trim
    |> Str.toUtf8
    |> List.splitOn '\n'
    |> List.mapTry \row ->
        row
        |> List.dropIf \char -> char == ' '
        |> List.mapTry \char ->
            when char is
                'O' -> Ok StoneO
                'X' -> Ok StoneX
                '.' -> Ok Empty
                _ -> Err (InvalidCharacter char)

## Ensure that the board has a least one cell, and that all rows have the same length
validate : Board -> Result {} [InvalidBoardShape]
validate = \board ->
    row_lengths = board |> List.map List.len |> Set.fromList
    if Set.len row_lengths != 1 || row_lengths == Set.fromList [0] then
        Err InvalidBoardShape
    else
        Ok {}

winner : Str -> Result [PlayerO, PlayerX] [NotFinished, InvalidCharacter U8, InvalidBoardShape]
winner = \board_str ->
    board = parse? board_str
    validate? board
    if board |> has_north_south_path StoneO then
        Ok PlayerO
    else if board |> transpose |> has_north_south_path StoneX then
        Ok PlayerX
    else
        Err NotFinished

transpose : Board -> Board
transpose = \board ->
    width = board |> first_row |> List.len
    List.range { start: At 0, end: Before width }
    |> List.map \x ->
        List.range { start: At 0, end: Before (board |> List.len) }
        |> List.map \y ->
            when board |> get_cell { x, y } is
                Ok cell -> cell
                Err OutOfBounds -> crash "Unreachable: all rows have the same length"

first_row : Board -> List Cell
first_row = \board ->
    when board |> List.first is
        Ok row -> row
        Err ListWasEmpty -> crash "Unreachable: the board has at least one cell"

get_cell : Board, Position -> Result Cell [OutOfBounds]
get_cell = \board, { x, y } ->
    board |> List.get? y |> List.get x

has_north_south_path : Board, Cell -> Bool
has_north_south_path = \board, stone ->
    has_path_to_south : List Position, Set Position -> Bool
    has_path_to_south = \to_visit, visited ->
        when to_visit is
            [] -> Bool.false
            [position, .. as rest] ->
                is_player_stone = board |> get_cell position == Ok stone
                if is_player_stone && !(visited |> Set.contains position) then
                    { x, y } = position
                    if y + 1 == List.len board then
                        Bool.true # we've reached the South!
                        else

                    neighbors =
                        [(-1, 0), (1, 0), (0, -1), (1, -1), (-1, 1), (0, 1)]
                        |> List.joinMap \(dx, dy) ->
                            nx = (x |> Num.toI64) + dx
                            ny = (y |> Num.toI64) + dy
                            if nx >= 0 && ny >= 0 then
                                [{ x: nx |> Num.toU64, y: ny |> Num.toU64 }]
                            else
                                []
                    has_path_to_south (rest |> List.concat neighbors) (visited |> Set.insert position)
                else
                    has_path_to_south rest visited

    north_stones : List Position
    north_stones =
        board
        |> first_row
        |> List.mapWithIndex \cell, x ->
            when cell is
                StoneO | StoneX -> if cell == stone then Ok { x, y: 0 } else Err NotPlayerStone
                Empty -> Err NotPlayerStone
        |> List.keepOks \id -> id
    has_path_to_south north_stones (Set.empty {})