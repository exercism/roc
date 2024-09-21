module [create, canAttack]

## Some Chess lovers might be shocked that we are using the words "row" and
## "column" rather than "rank" and "file", but ranks and files are usually
## 1-indexed whereas we are using 0-indexing in this exercise.
Queen : { row : U8, column : U8 }

create : Queen -> Result Queen [OutOfBoard]
create = \{ row, column } ->
    if row >= 8 || column >= 8 then
        Err OutOfBoard
    else
        Ok { row, column }

canAttack : Queen, Queen -> Bool
canAttack = \whiteQueen, blackQueen ->
    absDiff = \a, b -> if a < b then b - a else a - b
    rowDiff = absDiff whiteQueen.row blackQueen.row
    columnDiff = absDiff whiteQueen.column blackQueen.column
    rowDiff == 0 || columnDiff == 0 || rowDiff == columnDiff
