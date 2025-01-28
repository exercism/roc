# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/queen-attack/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import QueenAttack exposing [create, rank, file, queen_can_attack]

##
## Test creation of Queens with valid and invalid positions
##

# queen with a valid position
expect
    maybe_square = create("C6")
    result =
        maybe_square
        |> Result.try(
            |square|
                Ok(rank(square)),
        )
    result == Ok(6)

expect
    maybe_square = create("C6")
    result =
        maybe_square
        |> Result.try(
            |square|
                Ok(file(square)),
        )
    result == Ok('C')

# queen must have row on board
expect
    result = create("E0")
    result |> Result.is_err

# queen must have column on board
expect
    result = create("I4")
    result |> Result.is_err

##
## Test the ability of one queen to attack another
##

# cannot attack
expect
    maybe_square1 = create("E6")
    maybe_square2 = create("G2")
    result =
        when (maybe_square1, maybe_square2) is
            (Ok(square1), Ok(square2)) ->
                square1 |> queen_can_attack(square2)

            _ -> crash("Unreachable: E6 and G2 are both valid squares")
    result == Bool.false

# can attack on same row
expect
    maybe_square1 = create("E6")
    maybe_square2 = create("G6")
    result =
        when (maybe_square1, maybe_square2) is
            (Ok(square1), Ok(square2)) ->
                square1 |> queen_can_attack(square2)

            _ -> crash("Unreachable: E6 and G6 are both valid squares")
    result == Bool.true

# can attack on same column
expect
    maybe_square1 = create("F4")
    maybe_square2 = create("F6")
    result =
        when (maybe_square1, maybe_square2) is
            (Ok(square1), Ok(square2)) ->
                square1 |> queen_can_attack(square2)

            _ -> crash("Unreachable: F4 and F6 are both valid squares")
    result == Bool.true

# can attack on first diagonal
expect
    maybe_square1 = create("C6")
    maybe_square2 = create("E8")
    result =
        when (maybe_square1, maybe_square2) is
            (Ok(square1), Ok(square2)) ->
                square1 |> queen_can_attack(square2)

            _ -> crash("Unreachable: C6 and E8 are both valid squares")
    result == Bool.true

# can attack on second diagonal
expect
    maybe_square1 = create("C6")
    maybe_square2 = create("B5")
    result =
        when (maybe_square1, maybe_square2) is
            (Ok(square1), Ok(square2)) ->
                square1 |> queen_can_attack(square2)

            _ -> crash("Unreachable: C6 and B5 are both valid squares")
    result == Bool.true

# can attack on third diagonal
expect
    maybe_square1 = create("C6")
    maybe_square2 = create("B7")
    result =
        when (maybe_square1, maybe_square2) is
            (Ok(square1), Ok(square2)) ->
                square1 |> queen_can_attack(square2)

            _ -> crash("Unreachable: C6 and B7 are both valid squares")
    result == Bool.true

# can attack on fourth diagonal
expect
    maybe_square1 = create("H7")
    maybe_square2 = create("G8")
    result =
        when (maybe_square1, maybe_square2) is
            (Ok(square1), Ok(square2)) ->
                square1 |> queen_can_attack(square2)

            _ -> crash("Unreachable: H7 and G8 are both valid squares")
    result == Bool.true

# cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal
expect
    maybe_square1 = create("B4")
    maybe_square2 = create("F6")
    result =
        when (maybe_square1, maybe_square2) is
            (Ok(square1), Ok(square2)) ->
                square1 |> queen_can_attack(square2)

            _ -> crash("Unreachable: B4 and F6 are both valid squares")
    result == Bool.false

