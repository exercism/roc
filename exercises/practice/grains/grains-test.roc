# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/grains/canonical-data.json
# File last updated on 2024-08-26
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import Grains exposing [grainsOnSquare, totalGrains]

##
## returns the number of grains on the square
##

# grains on square 1
expect grainsOnSquare 1 == Ok 1

# grains on square 2
expect grainsOnSquare 2 == Ok 2

# grains on square 3
expect grainsOnSquare 3 == Ok 4

# grains on square 4
expect grainsOnSquare 4 == Ok 8

# grains on square 16
expect grainsOnSquare 16 == Ok 32768

# grains on square 32
expect grainsOnSquare 32 == Ok 2147483648

# grains on square 64
expect grainsOnSquare 64 == Ok 9223372036854775808

# square 0 is invalid
expect grainsOnSquare 0 == Err "square must be between 1 and 64"

# negative square is invalid
expect grainsOnSquare -1 == Err "square must be between 1 and 64"

# square greater than 64 is invalid
expect grainsOnSquare 65 == Err "square must be between 1 and 64"

##
## returns the total number of grains on the board
##

expect totalGrains == 18446744073709551615
