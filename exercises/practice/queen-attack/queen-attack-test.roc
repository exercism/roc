# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/queen-attack/canonical-data.json
# File last updated on 2024-09-21
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import QueenAttack exposing [create, canAttack]

##
## Test creation of Queens with valid and invalid positions
##

# queen with a valid position
expect
    result = create { row: 2, column: 2 }
    expected = Ok { row: 2, column: 2 }
    result == expected

# queen must have row on board
expect
    result = create { row: 8, column: 4 }
    result |> Result.isErr

# queen must have column on board
expect
    result = create { row: 4, column: 8 }
    result |> Result.isErr

##
## Test the ability of one queen to attack another
##

# cannot attack
expect
    maybeWhiteQueen = create { row: 2, column: 4 }
    maybeBlackQueen = create { row: 6, column: 6 }
    result =
        when (maybeWhiteQueen, maybeBlackQueen) is
            (Ok whiteQueen, Ok blackQueen) -> whiteQueen |> canAttack blackQueen
            _ -> Bool.false
    result == Bool.false

# can attack on same row
expect
    maybeWhiteQueen = create { row: 2, column: 4 }
    maybeBlackQueen = create { row: 2, column: 6 }
    result =
        when (maybeWhiteQueen, maybeBlackQueen) is
            (Ok whiteQueen, Ok blackQueen) -> whiteQueen |> canAttack blackQueen
            _ -> Bool.false
    result == Bool.true

# can attack on same column
expect
    maybeWhiteQueen = create { row: 4, column: 5 }
    maybeBlackQueen = create { row: 2, column: 5 }
    result =
        when (maybeWhiteQueen, maybeBlackQueen) is
            (Ok whiteQueen, Ok blackQueen) -> whiteQueen |> canAttack blackQueen
            _ -> Bool.false
    result == Bool.true

# can attack on first diagonal
expect
    maybeWhiteQueen = create { row: 2, column: 2 }
    maybeBlackQueen = create { row: 0, column: 4 }
    result =
        when (maybeWhiteQueen, maybeBlackQueen) is
            (Ok whiteQueen, Ok blackQueen) -> whiteQueen |> canAttack blackQueen
            _ -> Bool.false
    result == Bool.true

# can attack on second diagonal
expect
    maybeWhiteQueen = create { row: 2, column: 2 }
    maybeBlackQueen = create { row: 3, column: 1 }
    result =
        when (maybeWhiteQueen, maybeBlackQueen) is
            (Ok whiteQueen, Ok blackQueen) -> whiteQueen |> canAttack blackQueen
            _ -> Bool.false
    result == Bool.true

# can attack on third diagonal
expect
    maybeWhiteQueen = create { row: 2, column: 2 }
    maybeBlackQueen = create { row: 1, column: 1 }
    result =
        when (maybeWhiteQueen, maybeBlackQueen) is
            (Ok whiteQueen, Ok blackQueen) -> whiteQueen |> canAttack blackQueen
            _ -> Bool.false
    result == Bool.true

# can attack on fourth diagonal
expect
    maybeWhiteQueen = create { row: 1, column: 7 }
    maybeBlackQueen = create { row: 0, column: 6 }
    result =
        when (maybeWhiteQueen, maybeBlackQueen) is
            (Ok whiteQueen, Ok blackQueen) -> whiteQueen |> canAttack blackQueen
            _ -> Bool.false
    result == Bool.true

# cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal
expect
    maybeWhiteQueen = create { row: 4, column: 1 }
    maybeBlackQueen = create { row: 2, column: 5 }
    result =
        when (maybeWhiteQueen, maybeBlackQueen) is
            (Ok whiteQueen, Ok blackQueen) -> whiteQueen |> canAttack blackQueen
            _ -> Bool.false
    result == Bool.false

