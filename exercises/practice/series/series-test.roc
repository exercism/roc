# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/series/canonical-data.json
# File last updated on 2024-09-11
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Series exposing [slices]

# slices of one from one
expect
    result = "1" |> slices 1
    result == Ok ["1"]

# slices of one from two
expect
    result = "12" |> slices 1
    result == Ok ["1", "2"]

# slices of two
expect
    result = "35" |> slices 2
    result == Ok ["35"]

# slices of two overlap
expect
    result = "9142" |> slices 2
    result == Ok ["91", "14", "42"]

# slices can include duplicates
expect
    result = "777777" |> slices 3
    result == Ok ["777", "777", "777", "777"]

# slices of a long series
expect
    result = "918493904243" |> slices 5
    result == Ok ["91849", "18493", "84939", "49390", "93904", "39042", "90424", "04243"]

# slice length is too large
expect
    result = "12345" |> slices 6
    result |> Result.isErr

# slice length is way too large
expect
    result = "12345" |> slices 42
    result |> Result.isErr

# slice length cannot be zero
expect
    result = "12345" |> slices 0
    result |> Result.isErr

# empty series is invalid
expect
    result = "" |> slices 1
    result |> Result.isErr

