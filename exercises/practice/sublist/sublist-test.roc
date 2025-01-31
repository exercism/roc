# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/sublist/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Sublist exposing [sublist]

# empty lists
expect
    result = [] |> sublist([])
    result == Equal

# empty list within non empty list
expect
    result = [] |> sublist([1, 2, 3])
    result == Sublist

# non empty list contains empty list
expect
    result = [1, 2, 3] |> sublist([])
    result == Superlist

# list equals itself
expect
    result = [1, 2, 3] |> sublist([1, 2, 3])
    result == Equal

# different lists
expect
    result = [1, 2, 3] |> sublist([2, 3, 4])
    result == Unequal

# false start
expect
    result = [1, 2, 5] |> sublist([0, 1, 2, 3, 1, 2, 5, 6])
    result == Sublist

# consecutive
expect
    result = [1, 1, 2] |> sublist([0, 1, 1, 1, 2, 1, 2])
    result == Sublist

# sublist at start
expect
    result = [0, 1, 2] |> sublist([0, 1, 2, 3, 4, 5])
    result == Sublist

# sublist in middle
expect
    result = [2, 3, 4] |> sublist([0, 1, 2, 3, 4, 5])
    result == Sublist

# sublist at end
expect
    result = [3, 4, 5] |> sublist([0, 1, 2, 3, 4, 5])
    result == Sublist

# at start of superlist
expect
    result = [0, 1, 2, 3, 4, 5] |> sublist([0, 1, 2])
    result == Superlist

# in middle of superlist
expect
    result = [0, 1, 2, 3, 4, 5] |> sublist([2, 3])
    result == Superlist

# at end of superlist
expect
    result = [0, 1, 2, 3, 4, 5] |> sublist([3, 4, 5])
    result == Superlist

# first list missing element from second list
expect
    result = [1, 3] |> sublist([1, 2, 3])
    result == Unequal

# second list missing element from first list
expect
    result = [1, 2, 3] |> sublist([1, 3])
    result == Unequal

# first list missing additional digits from second list
expect
    result = [1, 2] |> sublist([1, 22])
    result == Unequal

# order matters to a list
expect
    result = [1, 2, 3] |> sublist([3, 2, 1])
    result == Unequal

# same digits but different numbers
expect
    result = [1, 0, 1] |> sublist([10, 1])
    result == Unequal

