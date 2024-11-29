module [annotate]

isBomb : List (List U8), I64, I64 -> Result Bool [OutOfBounds]
isBomb = \rows, nx, ny ->
    x = Num.toU64Checked? nx
    y = Num.toU64Checked? ny
    rows
        |> List.get? y
        |> List.get? x
        |> Bool.isEq '*'
        |> Ok

countNeighbors : List (List U8), U64, U64 -> Num *
countNeighbors = \rows, x, y ->
    [-1, 0, 1]
    |> List.map \dy ->
        [-1, 0, 1]
        |> List.map \dx ->
            when isBomb rows (Num.toI64 x + dx) (Num.toI64 y + dy) is
                Ok bomb -> if bomb then 1 else 0
                Err OutOfBounds -> 0
        |> List.sum
    |> List.sum

annotate : Str -> Str
annotate = \minefield ->
    rows = minefield |> Str.toUtf8 |> List.splitOn '\n'
    annotated =
        rows
        |> List.mapWithIndex \row, y ->
            row
            |> List.mapWithIndex \cell, x ->
                if cell == '*' then
                    '*'
                else
                    when countNeighbors rows x y is
                        0 -> ' '
                        n -> '0' + n
            |> Str.fromUtf8

    annotated
    |> List.map \maybeRow ->
        when maybeRow is
            Ok row -> row
            Err _ -> crash "Unreachable" # fromUtf8 cannot fail in the code above
    |> Str.joinWith "\n"
