# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/queen-attack/canonical-data.json
# File last updated on 2024-09-21
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import QueenAttack exposing [create, rank, file, queenCanAttack]

##
## Test creation of Queens with valid and invalid positions
##

# queen with a valid position
expect
    maybeSquare = create "C6"
    result =
        maybeSquare
        |> Result.try \square ->
            Ok (rank square)
    result == Ok 6

expect
    maybeSquare = create "C6"
    result =
        maybeSquare
        |> Result.try \square ->
            Ok (file square)
    result == Ok 'C'

# queen must have row on board
expect
    result = create "E0"
    result |> Result.isErr

# queen must have column on board
expect
    result = create "I4"
    result |> Result.isErr

##
## Test the ability of one queen to attack another
##

# cannot attack
expect
    maybeSquare1 = create "E6"
    maybeSquare2 = create "G2"
    result =
        when (maybeSquare1, maybeSquare2) is
            (Ok square1, Ok square2) ->
                square1 |> queenCanAttack square2

            _ -> crash "Unreachable: E6 and G2 are both valid squares"
    result == Bool.false

# can attack on same row
expect
    maybeSquare1 = create "E6"
    maybeSquare2 = create "G6"
    result =
        when (maybeSquare1, maybeSquare2) is
            (Ok square1, Ok square2) ->
                square1 |> queenCanAttack square2

            _ -> crash "Unreachable: E6 and G6 are both valid squares"
    result == Bool.true

# can attack on same column
expect
    maybeSquare1 = create "F4"
    maybeSquare2 = create "F6"
    result =
        when (maybeSquare1, maybeSquare2) is
            (Ok square1, Ok square2) ->
                square1 |> queenCanAttack square2

            _ -> crash "Unreachable: F4 and F6 are both valid squares"
    result == Bool.true

# can attack on first diagonal
expect
    maybeSquare1 = create "C6"
    maybeSquare2 = create "E8"
    result =
        when (maybeSquare1, maybeSquare2) is
            (Ok square1, Ok square2) ->
                square1 |> queenCanAttack square2

            _ -> crash "Unreachable: C6 and E8 are both valid squares"
    result == Bool.true

# can attack on second diagonal
expect
    maybeSquare1 = create "C6"
    maybeSquare2 = create "B5"
    result =
        when (maybeSquare1, maybeSquare2) is
            (Ok square1, Ok square2) ->
                square1 |> queenCanAttack square2

            _ -> crash "Unreachable: C6 and B5 are both valid squares"
    result == Bool.true

# can attack on third diagonal
expect
    maybeSquare1 = create "C6"
    maybeSquare2 = create "B7"
    result =
        when (maybeSquare1, maybeSquare2) is
            (Ok square1, Ok square2) ->
                square1 |> queenCanAttack square2

            _ -> crash "Unreachable: C6 and B7 are both valid squares"
    result == Bool.true

# can attack on fourth diagonal
expect
    maybeSquare1 = create "H7"
    maybeSquare2 = create "G8"
    result =
        when (maybeSquare1, maybeSquare2) is
            (Ok square1, Ok square2) ->
                square1 |> queenCanAttack square2

            _ -> crash "Unreachable: H7 and G8 are both valid squares"
    result == Bool.true

# cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal
expect
    maybeSquare1 = create "B4"
    maybeSquare2 = create "F6"
    result =
        when (maybeSquare1, maybeSquare2) is
            (Ok square1, Ok square2) ->
                square1 |> queenCanAttack square2

            _ -> crash "Unreachable: B4 and F6 are both valid squares"
    result == Bool.false

