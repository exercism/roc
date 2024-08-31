module [annotate]

isBomb : List Str, I64, I64 -> Result Bool [OutOfBounds]
isBomb = \rows, nx, ny ->
    if nx < 0 || ny < 0 then
        Err OutOfBounds
    else
        rowChars = rows |> List.get? (Num.toU64 ny) |> Str.toUtf8
        rowChars |> List.get? (Num.toU64 nx) |> Bool.isEq '*' |> Ok

countNeighbors : List Str, U64, U64 -> Num *
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
    rows = minefield |> Str.split "\n"
    annotated =
        rows
        |> List.mapWithIndex \row, y ->
            row
            |> Str.toUtf8
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
