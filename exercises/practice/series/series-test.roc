# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/series/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Series exposing [slices]

# slices of one from one
expect
    result = "1" |> slices(1)
    result == ["1"]

# slices of one from two
expect
    result = "12" |> slices(1)
    result == ["1", "2"]

# slices of two
expect
    result = "35" |> slices(2)
    result == ["35"]

# slices of two overlap
expect
    result = "9142" |> slices(2)
    result == ["91", "14", "42"]

# slices can include duplicates
expect
    result = "777777" |> slices(3)
    result == ["777", "777", "777", "777"]

# slices of a long series
expect
    result = "918493904243" |> slices(5)
    result == ["91849", "18493", "84939", "49390", "93904", "39042", "90424", "04243"]

# slice length is too large – just return an empty list
expect
    result = "12345" |> slices(6)
    result == []

# slice length is way too large – just return an empty list
expect
    result = "12345" |> slices(42)
    result == []

# slice length cannot be zero – just return an empty list
expect
    result = "12345" |> slices(0)
    result == []

# empty series is invalid – just return an empty list
expect
    result = "" |> slices(1)
    result == []

