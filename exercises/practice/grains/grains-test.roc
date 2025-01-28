# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/grains/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Grains exposing [grains_on_square, total_grains]

##
## returns the number of grains on the square
##

# grains on square 1
expect
    result = grains_on_square(1)
    result == Ok(1)

# grains on square 2
expect
    result = grains_on_square(2)
    result == Ok(2)

# grains on square 3
expect
    result = grains_on_square(3)
    result == Ok(4)

# grains on square 4
expect
    result = grains_on_square(4)
    result == Ok(8)

# grains on square 16
expect
    result = grains_on_square(16)
    result == Ok(32768)

# grains on square 32
expect
    result = grains_on_square(32)
    result == Ok(2147483648)

# grains on square 64
expect
    result = grains_on_square(64)
    result == Ok(9223372036854775808)

# square 0 is invalid
expect
    result = grains_on_square(0)
    Result.is_err(result)

# square greater than 64 is invalid
expect
    result = grains_on_square(65)
    Result.is_err(result)

##
## returns the total number of grains on the board
##

expect
    result = total_grains
    result == 18446744073709551615
