# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/binary-search/canonical-data.json
# File last updated on 2024-09-03
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import BinarySearch exposing [find]

# finds a value in an array with one element
expect
    result = [6] |> find 6
    result == Ok 0

# finds a value in the middle of an array
expect
    result = [1, 3, 4, 6, 8, 9, 11] |> find 6
    result == Ok 3

# finds a value at the beginning of an array
expect
    result = [1, 3, 4, 6, 8, 9, 11] |> find 1
    result == Ok 0

# finds a value at the end of an array
expect
    result = [1, 3, 4, 6, 8, 9, 11] |> find 11
    result == Ok 6

# finds a value in an array of odd length
expect
    result = [1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634] |> find 144
    result == Ok 9

# finds a value in an array of even length
expect
    result = [1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377] |> find 21
    result == Ok 5

# identifies that a value is not included in the array
expect
    result = [1, 3, 4, 6, 8, 9, 11] |> find 7
    Result.isErr result

# a value smaller than the array's smallest value is not found
expect
    result = [1, 3, 4, 6, 8, 9, 11] |> find 0
    Result.isErr result

# a value larger than the array's largest value is not found
expect
    result = [1, 3, 4, 6, 8, 9, 11] |> find 13
    Result.isErr result

# nothing is found in an empty array
expect
    result = [] |> find 1
    Result.isErr result

# nothing is found when the left and right bounds cross
expect
    result = [1, 2] |> find 0
    Result.isErr result

