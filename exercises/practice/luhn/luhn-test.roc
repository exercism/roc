# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/luhn/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Luhn exposing [valid]

# single digit strings can not be valid
expect
    result = valid("1")
    result == Bool.false

# a single zero is invalid
expect
    result = valid("0")
    result == Bool.false

# a simple valid SIN that remains valid if reversed
expect
    result = valid("059")
    result == Bool.true

# a simple valid SIN that becomes invalid if reversed
expect
    result = valid("59")
    result == Bool.true

# a valid Canadian SIN
expect
    result = valid("055 444 285")
    result == Bool.true

# invalid Canadian SIN
expect
    result = valid("055 444 286")
    result == Bool.false

# invalid credit card
expect
    result = valid("8273 1232 7352 0569")
    result == Bool.false

# invalid long number with an even remainder
expect
    result = valid("1 2345 6789 1234 5678 9012")
    result == Bool.false

# invalid long number with a remainder divisible by 5
expect
    result = valid("1 2345 6789 1234 5678 9013")
    result == Bool.false

# valid number with an even number of digits
expect
    result = valid("095 245 88")
    result == Bool.true

# valid number with an odd number of spaces
expect
    result = valid("234 567 891 234")
    result == Bool.true

# valid strings with a non-digit added at the end become invalid
expect
    result = valid("059a")
    result == Bool.false

# valid strings with punctuation included become invalid
expect
    result = valid("055-444-285")
    result == Bool.false

# valid strings with symbols included become invalid
expect
    result = valid("055# 444$ 285")
    result == Bool.false

# single zero with space is invalid
expect
    result = valid(" 0")
    result == Bool.false

# more than a single zero is valid
expect
    result = valid("0000 0")
    result == Bool.true

# input digit 9 is correctly converted to output digit 9
expect
    result = valid("091")
    result == Bool.true

# very long input is valid
expect
    result = valid("9999999999 9999999999 9999999999 9999999999")
    result == Bool.true

# valid luhn with an odd number of digits and non zero first digit
expect
    result = valid("109")
    result == Bool.true

# using ascii value for non-doubled non-digit isn't allowed
expect
    result = valid("055b 444 285")
    result == Bool.false

# using ascii value for doubled non-digit isn't allowed
expect
    result = valid(":9")
    result == Bool.false

# non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed
expect
    result = valid("59%59")
    result == Bool.false

