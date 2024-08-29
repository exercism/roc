# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/grains/canonical-data.json
# File last updated on 2024-08-29
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
expect
    result = grainsOnSquare 1
    result == Ok 1

# grains on square 2
expect
    result = grainsOnSquare 2
    result == Ok 2

# grains on square 3
expect
    result = grainsOnSquare 3
    result == Ok 4

# grains on square 4
expect
    result = grainsOnSquare 4
    result == Ok 8

# grains on square 16
expect
    result = grainsOnSquare 16
    result == Ok 32768

# grains on square 32
expect
    result = grainsOnSquare 32
    result == Ok 2147483648

# grains on square 64
expect
    result = grainsOnSquare 64
    result == Ok 9223372036854775808

# square 0 is invalid
expect
    result = grainsOnSquare 0
    result == Err SquareMustBeBetween1And64

# negative square is invalid
expect
    result = grainsOnSquare -1
    result == Err SquareMustBeBetween1And64

# square greater than 64 is invalid
expect
    result = grainsOnSquare 65
    result == Err SquareMustBeBetween1And64

##
## returns the total number of grains on the board
##

expect
    result = totalGrains
    result == 18446744073709551615
