module [create, rank, file, queen_can_attack]

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

queen_can_attack : Square, Square -> Bool
queen_can_attack = \square1, square2 ->
    crash "Please implement the 'queen_can_attack' function"
