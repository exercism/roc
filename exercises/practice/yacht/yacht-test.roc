# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/yacht/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Yacht exposing [score]

# Yacht
expect
    result = [5, 5, 5, 5, 5] |> score(Yacht)
    result == 50

# Not Yacht
expect
    result = [1, 3, 3, 2, 5] |> score(Yacht)
    result == 0

# Ones
expect
    result = [1, 1, 1, 3, 5] |> score(Ones)
    result == 3

# Ones, out of order
expect
    result = [3, 1, 1, 5, 1] |> score(Ones)
    result == 3

# No ones
expect
    result = [4, 3, 6, 5, 5] |> score(Ones)
    result == 0

# Twos
expect
    result = [2, 3, 4, 5, 6] |> score(Twos)
    result == 2

# Fours
expect
    result = [1, 4, 1, 4, 1] |> score(Fours)
    result == 8

# Yacht counted as threes
expect
    result = [3, 3, 3, 3, 3] |> score(Threes)
    result == 15

# Yacht of 3s counted as fives
expect
    result = [3, 3, 3, 3, 3] |> score(Fives)
    result == 0

# Fives
expect
    result = [1, 5, 3, 5, 3] |> score(Fives)
    result == 10

# Sixes
expect
    result = [2, 3, 4, 5, 6] |> score(Sixes)
    result == 6

# Full house two small, three big
expect
    result = [2, 2, 4, 4, 4] |> score(FullHouse)
    result == 16

# Full house three small, two big
expect
    result = [5, 3, 3, 5, 3] |> score(FullHouse)
    result == 19

# Two pair is not a full house
expect
    result = [2, 2, 4, 4, 5] |> score(FullHouse)
    result == 0

# Four of a kind is not a full house
expect
    result = [1, 4, 4, 4, 4] |> score(FullHouse)
    result == 0

# Yacht is not a full house
expect
    result = [2, 2, 2, 2, 2] |> score(FullHouse)
    result == 0

# Four of a Kind
expect
    result = [6, 6, 4, 6, 6] |> score(FourOfAKind)
    result == 24

# Yacht can be scored as Four of a Kind
expect
    result = [3, 3, 3, 3, 3] |> score(FourOfAKind)
    result == 12

# Full house is not Four of a Kind
expect
    result = [3, 3, 3, 5, 5] |> score(FourOfAKind)
    result == 0

# Little Straight
expect
    result = [3, 5, 4, 1, 2] |> score(LittleStraight)
    result == 30

# Little Straight as Big Straight
expect
    result = [1, 2, 3, 4, 5] |> score(BigStraight)
    result == 0

# Four in order but not a little straight
expect
    result = [1, 1, 2, 3, 4] |> score(LittleStraight)
    result == 0

# No pairs but not a little straight
expect
    result = [1, 2, 3, 4, 6] |> score(LittleStraight)
    result == 0

# Minimum is 1, maximum is 5, but not a little straight
expect
    result = [1, 1, 3, 4, 5] |> score(LittleStraight)
    result == 0

# Big Straight
expect
    result = [4, 6, 2, 5, 3] |> score(BigStraight)
    result == 30

# Big Straight as little straight
expect
    result = [6, 5, 4, 3, 2] |> score(LittleStraight)
    result == 0

# No pairs but not a big straight
expect
    result = [6, 5, 4, 3, 1] |> score(BigStraight)
    result == 0

# Choice
expect
    result = [3, 3, 5, 6, 6] |> score(Choice)
    result == 23

# Yacht as choice
expect
    result = [2, 2, 2, 2, 2] |> score(Choice)
    result == 10

