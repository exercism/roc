# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/largest-series-product/canonical-data.json
# File last updated on 2024-10-13
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import LargestSeriesProduct exposing [largestProduct]

# finds the largest product if span equals length
expect
    digits = "29"
    result = digits |> largestProduct 2
    expected = Ok 18
    result == expected

# can find the largest product of 2 with numbers in order
expect
    digits = "0123456789"
    result = digits |> largestProduct 2
    expected = Ok 72
    result == expected

# can find the largest product of 2
expect
    digits = "576802143"
    result = digits |> largestProduct 2
    expected = Ok 48
    result == expected

# can find the largest product of 3 with numbers in order
expect
    digits = "0123456789"
    result = digits |> largestProduct 3
    expected = Ok 504
    result == expected

# can find the largest product of 3
expect
    digits = "1027839564"
    result = digits |> largestProduct 3
    expected = Ok 270
    result == expected

# can find the largest product of 5 with numbers in order
expect
    digits = "0123456789"
    result = digits |> largestProduct 5
    expected = Ok 15120
    result == expected

# can get the largest product of a big number
expect
    digits = "73167176531330624919225119674426574742355349194934"
    result = digits |> largestProduct 6
    expected = Ok 23520
    result == expected

# reports zero if the only digits are zero
expect
    digits = "0000"
    result = digits |> largestProduct 2
    expected = Ok 0
    result == expected

# reports zero if all spans include zero
expect
    digits = "99099"
    result = digits |> largestProduct 3
    expected = Ok 0
    result == expected

# rejects span longer than string length
expect
    digits = "123"
    result = digits |> largestProduct 4
    result |> Result.isErr

# reports 1 for empty string and empty product (0 span)
expect
    digits = ""
    result = digits |> largestProduct 0
    expected = Ok 1
    result == expected

# reports 1 for nonempty string and empty product (0 span)
expect
    digits = "123"
    result = digits |> largestProduct 0
    expected = Ok 1
    result == expected

# rejects empty string and nonzero span
expect
    digits = ""
    result = digits |> largestProduct 1
    result |> Result.isErr

# rejects invalid character in digits
expect
    digits = "1234a5"
    result = digits |> largestProduct 2
    result |> Result.isErr

