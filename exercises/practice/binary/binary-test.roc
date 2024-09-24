# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/binary/canonical-data.json
# File last updated on 2024-09-24
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Binary exposing [decimal]

# binary 0 is decimal 0
expect
    result = decimal "0"
    result == Ok 0

# binary 1 is decimal 1
expect
    result = decimal "1"
    result == Ok 1

# binary 10 is decimal 2
expect
    result = decimal "10"
    result == Ok 2

# binary 11 is decimal 3
expect
    result = decimal "11"
    result == Ok 3

# binary 100 is decimal 4
expect
    result = decimal "100"
    result == Ok 4

# binary 1001 is decimal 9
expect
    result = decimal "1001"
    result == Ok 9

# binary 11010 is decimal 26
expect
    result = decimal "11010"
    result == Ok 26

# binary 10001101000 is decimal 1128
expect
    result = decimal "10001101000"
    result == Ok 1128

# binary ignores leading zeros
expect
    result = decimal "000011111"
    result == Ok 31

# 2 is not a valid binary digit
expect
    result = decimal "2"
    result |> Result.isErr

# a number containing a non-binary digit is invalid
expect
    result = decimal "01201"
    result |> Result.isErr

# a number with trailing non-binary characters is invalid
expect
    result = decimal "10nope"
    result |> Result.isErr

# a number with leading non-binary characters is invalid
expect
    result = decimal "nope10"
    result |> Result.isErr

# a number with internal non-binary characters is invalid
expect
    result = decimal "10nope10"
    result |> Result.isErr

# a number and a word whitespace separated is invalid
expect
    result = decimal "001 nope"
    result |> Result.isErr

