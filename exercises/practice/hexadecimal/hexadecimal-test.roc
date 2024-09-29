# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/hexadecimal/canonical-data.json
# File last updated on 2024-09-29
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Hexadecimal exposing [parse]

# Parse "0"
expect
    result = parse "0"
    result == Ok 0

# Parse "1"
expect
    result = parse "1"
    result == Ok 1

# Parse "2"
expect
    result = parse "2"
    result == Ok 2

# Parse "3"
expect
    result = parse "3"
    result == Ok 3

# Parse "4"
expect
    result = parse "4"
    result == Ok 4

# Parse "5"
expect
    result = parse "5"
    result == Ok 5

# Parse "6"
expect
    result = parse "6"
    result == Ok 6

# Parse "7"
expect
    result = parse "7"
    result == Ok 7

# Parse "8"
expect
    result = parse "8"
    result == Ok 8

# Parse "9"
expect
    result = parse "9"
    result == Ok 9

# Parse "a"
expect
    result = parse "a"
    result == Ok 10

# Parse "b"
expect
    result = parse "b"
    result == Ok 11

# Parse "c"
expect
    result = parse "c"
    result == Ok 12

# Parse "d"
expect
    result = parse "d"
    result == Ok 13

# Parse "e"
expect
    result = parse "e"
    result == Ok 14

# Parse "f"
expect
    result = parse "f"
    result == Ok 15

# Parse "10"
expect
    result = parse "10"
    result == Ok 16

# Parse "11"
expect
    result = parse "11"
    result == Ok 17

# Parse "1f"
expect
    result = parse "1f"
    result == Ok 31

# Parse "ff"
expect
    result = parse "ff"
    result == Ok 255

# Parse "abc"
expect
    result = parse "abc"
    result == Ok 2748

# Parse "cafe"
expect
    result = parse "cafe"
    result == Ok 51966

# Parse "deadbeef"
expect
    result = parse "deadbeef"
    result == Ok 3735928559

# Parse "123456789abcdef"
expect
    result = parse "123456789abcdef"
    result == Ok 81985529216486895

# Parse "ffffffffffffffff", the largest U64 value
expect
    result = parse "ffffffffffffffff"
    result == Ok 18446744073709551615

# Ignore leading zeros in "00000"
expect
    result = parse "00000"
    result == Ok 0

# Ignore leading zeros in "00001"
expect
    result = parse "00001"
    result == Ok 1

# Ignore leading zeros in "0000a"
expect
    result = parse "0000a"
    result == Ok 10

# Ignore leading zeros in "000010"
expect
    result = parse "000010"
    result == Ok 16

# Ignore leading zeros in "0000ff"
expect
    result = parse "0000ff"
    result == Ok 255

# Ignore leading zeros in "0000a0000"
expect
    result = parse "0000a0000"
    result == Ok 655360

# Ignore leading zeros even before the largest U64 value
expect
    result = parse "0000ffffffffffffffff"
    result == Ok 18446744073709551615

# Accept upper case
expect
    result = parse "ABCDEF"
    result == Ok 11259375

# Accept mixed case
expect
    result = parse "aAbBcCdDeEfF"
    result == Ok 187723572702975

# Empty strings are invalid
expect
    result = parse ""
    result |> Result.isErr

# A string with only spaces is invalid
expect
    result = parse "   "
    result |> Result.isErr

# Leading spaces are invalid
expect
    result = parse " 12ab"
    result |> Result.isErr

# Trailing spaces are invalid
expect
    result = parse "12ab "
    result |> Result.isErr

# Spaces anywhere are invalid
expect
    result = parse "12 ab"
    result |> Result.isErr

# Invalid character in "1*2ab"
expect
    result = parse "1*2ab"
    result |> Result.isErr

# Invalid character in "12fg"
expect
    result = parse "12fg"
    result |> Result.isErr

# Invalid character in "12/ab"
expect
    result = parse "12/ab"
    result |> Result.isErr

# Invalid character in "12ab\n"
expect
    result = parse "12ab\n"
    result |> Result.isErr

# Invalid character in "12-ab"
expect
    result = parse "12-ab"
    result |> Result.isErr

# Invalid character in "12+ab"
expect
    result = parse "12+ab"
    result |> Result.isErr

# For numbers that don't fit in an U64, `parse` should return an error
# instead of crashing
expect
    result = parse "100000000000000000000000000000000"
    result |> Result.isErr
