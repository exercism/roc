app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
}

main! = \_args ->
    Ok {}

import Octal exposing [parse]

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

# Parse "10"
expect
    result = parse "10"
    result == Ok 8

# Parse "11"
expect
    result = parse "11"
    result == Ok 9

# Parse "12"
expect
    result = parse "12"
    result == Ok 10

# Parse "13"
expect
    result = parse "13"
    result == Ok 11

# Parse "14"
expect
    result = parse "14"
    result == Ok 12

# Parse "15"
expect
    result = parse "15"
    result == Ok 13

# Parse "16"
expect
    result = parse "16"
    result == Ok 14

# Parse "17"
expect
    result = parse "17"
    result == Ok 15

# Parse "20"
expect
    result = parse "20"
    result == Ok 16

# Parse "21"
expect
    result = parse "21"
    result == Ok 17

# Parse "22"
expect
    result = parse "22"
    result == Ok 18

# Parse "77"
expect
    result = parse "77"
    result == Ok 63

# Parse "100"
expect
    result = parse "100"
    result == Ok 64

# Parse "1234567654321"
expect
    result = parse "1234567654321"
    result == Ok 89755965649

# Parse "1777777777777777777777", the largest U64 value
expect
    result = parse "1777777777777777777777"
    result == Ok 18446744073709551615

# Ignore leading zeros in "00000"
expect
    result = parse "00000"
    result == Ok 0

# Ignore leading zeros in "00001"
expect
    result = parse "00001"
    result == Ok 1

# Ignore leading zeros in "00007"
expect
    result = parse "00007"
    result == Ok 7

# Ignore leading zeros in "000010"
expect
    result = parse "000010"
    result == Ok 8

# Ignore leading zeros in "000077"
expect
    result = parse "000077"
    result == Ok 63

# Ignore leading zeros in "000070000"
expect
    result = parse "000070000"
    result == Ok 28672

# Ignore leading zeros even before the largest U64 value
expect
    result = parse "00001777777777777777777777"
    result == Ok 18446744073709551615

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
    result = parse " 1234567"
    result |> Result.isErr

# Trailing spaces are invalid
expect
    result = parse "1234567 "
    result |> Result.isErr

# Spaces anywhere are invalid
expect
    result = parse "123 4567"
    result |> Result.isErr

# Invalid character in "1*234"
expect
    result = parse "1*234"
    result |> Result.isErr

# Invalid character in "12abc"
expect
    result = parse "12abc"
    result |> Result.isErr

# Invalid character in "12/34"
expect
    result = parse "12/34"
    result |> Result.isErr

# Invalid character in "1234\n"
expect
    result = parse "1234\n"
    result |> Result.isErr

# Invalid character in "-1234"
expect
    result = parse "-1234"
    result |> Result.isErr

# Invalid character in "+1234"
expect
    result = parse "+1234"
    result |> Result.isErr

# For numbers that don't fit in an U64, `parse` should return an error
# instead of crashing
expect
    result = parse "2000000000000000000000"
    result |> Result.isErr
