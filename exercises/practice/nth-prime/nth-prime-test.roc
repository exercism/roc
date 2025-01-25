# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/nth-prime/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/bi5zubJ-_Hva9vxxPq4kNx4WHX6oFs8OP6Ad0tCYlrY.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import NthPrime exposing [prime]

# first prime
expect
    result = prime(1)
    result == Ok(2)

# second prime
expect
    result = prime(2)
    result == Ok(3)

# sixth prime
expect
    result = prime(6)
    result == Ok(13)

# big prime
expect
    result = prime(10001)
    result == Ok(104743)

# there is no zeroth prime
expect
    result = prime(0)
    result |> Result.is_err

