module [create, canAttack]

## Some Chess lovers might be shocked that we are using the words "row" and
## "column" rather than "rank" and "file", but ranks and files are usually
## 1-indexed whereas we are using 0-indexing in this exercise.
Queen := { row : U8, column : U8 }

create : Queen -> Result Queen _
create = \{ row, column } ->
    crash "Please implement the 'create' function"

canAttack : Queen, Queen -> Bool
canAttack = \whiteQueen, blackQueen ->
    crash "Please implement the 'canAttack' function"
