module [create, rank, file, queen_can_attack]

Square := { row : U8, column : U8 }

rank : Square -> U8
rank = \@Square { row, column: _ } -> 8 - row

file : Square -> U8
file = \@Square { row: _, column } -> column + 'A'

create : Str -> Result Square [InvalidSquare]
create = \square_str ->
    chars = square_str |> Str.toUtf8
    if List.len chars != 2 then
        Err InvalidSquare
        else

    file_char = chars |> List.get 0 |> Result.mapErr? \OutOfBounds -> InvalidSquare
    rank_char = chars |> List.get 1 |> Result.mapErr? \OutOfBounds -> InvalidSquare
    if file_char < 'A' || file_char > 'H' || rank_char < '1' || rank_char > '8' then
        Err InvalidSquare
    else
        Ok (@Square { row: 7 - (rank_char - '1'), column: file_char - 'A' })

queen_can_attack : Square, Square -> Bool
queen_can_attack = \@Square { row: r1, column: c1 }, @Square { row: r2, column: c2 } ->
    abs_diff = \u, v -> if u < v then v - u else u - v
    row_diff = abs_diff r1 r2
    column_diff = abs_diff c1 c2
    row_diff == 0 || column_diff == 0 || row_diff == column_diff