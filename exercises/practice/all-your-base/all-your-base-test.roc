# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/all-your-base/canonical-data.json
# File last updated on 2024-09-03
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import AllYourBase exposing [rebase]

# single bit one to decimal
expect
    result = rebase { inputBase: 2, outputBase: 10, digits: [1] }
    result == Ok [1]

# binary to single decimal
expect
    result = rebase { inputBase: 2, outputBase: 10, digits: [1, 0, 1] }
    result == Ok [5]

# single decimal to binary
expect
    result = rebase { inputBase: 10, outputBase: 2, digits: [5] }
    result == Ok [1, 0, 1]

# binary to multiple decimal
expect
    result = rebase { inputBase: 2, outputBase: 10, digits: [1, 0, 1, 0, 1, 0] }
    result == Ok [4, 2]

# decimal to binary
expect
    result = rebase { inputBase: 10, outputBase: 2, digits: [4, 2] }
    result == Ok [1, 0, 1, 0, 1, 0]

# trinary to hexadecimal
expect
    result = rebase { inputBase: 3, outputBase: 16, digits: [1, 1, 2, 0] }
    result == Ok [2, 10]

# hexadecimal to trinary
expect
    result = rebase { inputBase: 16, outputBase: 3, digits: [2, 10] }
    result == Ok [1, 1, 2, 0]

# 15-bit integer
expect
    result = rebase { inputBase: 97, outputBase: 73, digits: [3, 46, 60] }
    result == Ok [6, 10, 45]

# empty list
expect
    result = rebase { inputBase: 2, outputBase: 10, digits: [] }
    result == Ok [0]

# single zero
expect
    result = rebase { inputBase: 10, outputBase: 2, digits: [0] }
    result == Ok [0]

# multiple zeros
expect
    result = rebase { inputBase: 10, outputBase: 2, digits: [0, 0, 0] }
    result == Ok [0]

# leading zeros
expect
    result = rebase { inputBase: 7, outputBase: 10, digits: [0, 6, 0] }
    result == Ok [4, 2]

# input base is one
expect
    result = rebase { inputBase: 1, outputBase: 10, digits: [0] }
    result |> Result.isErr

# input base is zero
expect
    result = rebase { inputBase: 0, outputBase: 10, digits: [] }
    result |> Result.isErr

# invalid positive digit
expect
    result = rebase { inputBase: 2, outputBase: 10, digits: [1, 2, 1, 0, 1, 0] }
    result |> Result.isErr

# output base is one
expect
    result = rebase { inputBase: 2, outputBase: 1, digits: [1, 0, 1, 0, 1, 0] }
    result |> Result.isErr

# output base is zero
expect
    result = rebase { inputBase: 10, outputBase: 0, digits: [7] }
    result |> Result.isErr
