# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/all-your-base/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import AllYourBase exposing [rebase]

# single bit one to decimal
expect
    result = rebase({ input_base: 2, output_base: 10, digits: [1] })
    result == Ok([1])

# binary to single decimal
expect
    result = rebase({ input_base: 2, output_base: 10, digits: [1, 0, 1] })
    result == Ok([5])

# single decimal to binary
expect
    result = rebase({ input_base: 10, output_base: 2, digits: [5] })
    result == Ok([1, 0, 1])

# binary to multiple decimal
expect
    result = rebase({ input_base: 2, output_base: 10, digits: [1, 0, 1, 0, 1, 0] })
    result == Ok([4, 2])

# decimal to binary
expect
    result = rebase({ input_base: 10, output_base: 2, digits: [4, 2] })
    result == Ok([1, 0, 1, 0, 1, 0])

# trinary to hexadecimal
expect
    result = rebase({ input_base: 3, output_base: 16, digits: [1, 1, 2, 0] })
    result == Ok([2, 10])

# hexadecimal to trinary
expect
    result = rebase({ input_base: 16, output_base: 3, digits: [2, 10] })
    result == Ok([1, 1, 2, 0])

# 15-bit integer
expect
    result = rebase({ input_base: 97, output_base: 73, digits: [3, 46, 60] })
    result == Ok([6, 10, 45])

# empty list
expect
    result = rebase({ input_base: 2, output_base: 10, digits: [] })
    result == Ok([0])

# single zero
expect
    result = rebase({ input_base: 10, output_base: 2, digits: [0] })
    result == Ok([0])

# multiple zeros
expect
    result = rebase({ input_base: 10, output_base: 2, digits: [0, 0, 0] })
    result == Ok([0])

# leading zeros
expect
    result = rebase({ input_base: 7, output_base: 10, digits: [0, 6, 0] })
    result == Ok([4, 2])

# input base is one
expect
    result = rebase({ input_base: 1, output_base: 10, digits: [0] })
    result |> Result.is_err

# input base is zero
expect
    result = rebase({ input_base: 0, output_base: 10, digits: [] })
    result |> Result.is_err

# invalid positive digit
expect
    result = rebase({ input_base: 2, output_base: 10, digits: [1, 2, 1, 0, 1, 0] })
    result |> Result.is_err

# output base is one
expect
    result = rebase({ input_base: 2, output_base: 1, digits: [1, 0, 1, 0, 1, 0] })
    result |> Result.is_err

# output base is zero
expect
    result = rebase({ input_base: 10, output_base: 0, digits: [7] })
    result |> Result.is_err

