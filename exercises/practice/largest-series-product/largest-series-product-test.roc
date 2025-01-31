# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/largest-series-product/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import LargestSeriesProduct exposing [largest_product]

# finds the largest product if span equals length
expect
    digits = "29"
    result = digits |> largest_product(2)
    expected = Ok(18)
    result == expected

# can find the largest product of 2 with numbers in order
expect
    digits = "0123456789"
    result = digits |> largest_product(2)
    expected = Ok(72)
    result == expected

# can find the largest product of 2
expect
    digits = "576802143"
    result = digits |> largest_product(2)
    expected = Ok(48)
    result == expected

# can find the largest product of 3 with numbers in order
expect
    digits = "0123456789"
    result = digits |> largest_product(3)
    expected = Ok(504)
    result == expected

# can find the largest product of 3
expect
    digits = "1027839564"
    result = digits |> largest_product(3)
    expected = Ok(270)
    result == expected

# can find the largest product of 5 with numbers in order
expect
    digits = "0123456789"
    result = digits |> largest_product(5)
    expected = Ok(15120)
    result == expected

# can get the largest product of a big number
expect
    digits = "73167176531330624919225119674426574742355349194934"
    result = digits |> largest_product(6)
    expected = Ok(23520)
    result == expected

# reports zero if the only digits are zero
expect
    digits = "0000"
    result = digits |> largest_product(2)
    expected = Ok(0)
    result == expected

# reports zero if all spans include zero
expect
    digits = "99099"
    result = digits |> largest_product(3)
    expected = Ok(0)
    result == expected

# rejects span longer than string length
expect
    digits = "123"
    result = digits |> largest_product(4)
    result |> Result.is_err

# reports 1 for empty string and empty product (0 span)
expect
    digits = ""
    result = digits |> largest_product(0)
    expected = Ok(1)
    result == expected

# reports 1 for nonempty string and empty product (0 span)
expect
    digits = "123"
    result = digits |> largest_product(0)
    expected = Ok(1)
    result == expected

# rejects empty string and nonzero span
expect
    digits = ""
    result = digits |> largest_product(1)
    result |> Result.is_err

# rejects invalid character in digits
expect
    digits = "1234a5"
    result = digits |> largest_product(2)
    result |> Result.is_err

