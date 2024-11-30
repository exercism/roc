module [winner]

Cell : [StoneO, StoneX, Empty]
Board : List (List Cell)
Position : { x : U64, y : U64 }

## Parse a string to a Board
parse : Str -> Result Board [InvalidCharacter U8]
parse = \boardStr ->
    boardStr
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
    rowLengths = board |> List.map List.len |> Set.fromList
    if Set.len rowLengths != 1 || rowLengths == Set.fromList [0] then
        Err InvalidBoardShape
    else
        Ok {}

winner : Str -> Result [PlayerO, PlayerX] [NotFinished, InvalidCharacter U8, InvalidBoardShape]
winner = \boardStr ->
    board = parse? boardStr
    validate? board
    if board |> hasNorthSouthPath StoneO then
        Ok PlayerO
    else if board |> transpose |> hasNorthSouthPath StoneX then
        Ok PlayerX
    else
        Err NotFinished

transpose : Board -> Board
transpose = \board ->
    width = board |> firstRow |> List.len
    List.range { start: At 0, end: Before width }
    |> List.map \x ->
        List.range { start: At 0, end: Before (board |> List.len) }
        |> List.map \y ->
            when board |> getCell { x, y } is
                Ok cell -> cell
                Err OutOfBounds -> crash "Unreachable: all rows have the same length"

firstRow : Board -> List Cell
firstRow = \board ->
    when board |> List.first is
        Ok row -> row
        Err ListWasEmpty -> crash "Unreachable: the board has at least one cell"

getCell : Board, Position -> Result Cell [OutOfBounds]
getCell = \board, { x, y } ->
    board |> List.get? y |> List.get x

hasNorthSouthPath : Board, Cell -> Bool
hasNorthSouthPath = \board, stone ->
    hasPathToSouth : List Position, Set Position -> Bool
    hasPathToSouth = \toVisit, visited ->
        when toVisit is
            [] -> Bool.false
            [position, .. as rest] ->
                isPlayerStone = board |> getCell position == Ok stone
                if isPlayerStone && !(visited |> Set.contains position) then
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
                    hasPathToSouth (rest |> List.concat neighbors) (visited |> Set.insert position)
                else
                    hasPathToSouth rest visited

    northStones : List Position
    northStones =
        board
        |> firstRow
        |> List.mapWithIndex \cell, x ->
            when cell is
                StoneO | StoneX -> if cell == stone then Ok { x, y: 0 } else Err NotPlayerStone
                Empty -> Err NotPlayerStone
        |> List.keepOks \id -> id
    hasPathToSouth northStones (Set.empty {})
