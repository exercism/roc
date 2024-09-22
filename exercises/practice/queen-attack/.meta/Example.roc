module [create, rank, file, queenCanAttack]

Square := { row : U8, column : U8 }

rank : Square -> U8
rank = \@Square { row, column: _ } -> 8 - row

file : Square -> U8
file = \@Square { row: _, column } -> column + 'A'

create : Str -> Result Square [InvalidSquare]
create = \squareStr ->
    chars = squareStr |> Str.toUtf8
    if List.len chars != 2 then
        Err InvalidSquare
        else

    fileChar = chars |> List.get 0 |> Result.mapErr? \OutOfBounds -> InvalidSquare
    rankChar = chars |> List.get 1 |> Result.mapErr? \OutOfBounds -> InvalidSquare
    if fileChar < 'A' || fileChar > 'H' || rankChar < '1' || rankChar > '8' then
        Err InvalidSquare
    else
        Ok (@Square { row: 7 - (rankChar - '1'), column: fileChar - 'A' })

queenCanAttack : Square, Square -> Bool
queenCanAttack = \@Square { row: r1, column: c1 }, @Square { row: r2, column: c2 } ->
    absDiff = \u, v -> if u < v then v - u else u - v
    rowDiff = absDiff r1 r2
    columnDiff = absDiff c1 c2
    rowDiff == 0 || columnDiff == 0 || rowDiff == columnDiff
