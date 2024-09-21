module [create, rank, file, queenCanAttack]

Square := { row : U8, column : U8 }

rank : Square -> U8
rank = \@Square { row, column } ->
    crash "Please implement the 'rank' function"

file : Square -> U8
file = \@Square { row, column } ->
    crash "Please implement the 'file' function"

create : Str -> Result Square _
create = \squareStr ->
    crash "Please implement the 'create' function"

queenCanAttack : Square, Square -> Bool
queenCanAttack = \square1, square2 ->
    crash "Please implement the 'queenCanAttack' function"
