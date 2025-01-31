# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/square-root/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import SquareRoot exposing [square_root]

# root of 1
expect
    result = square_root(1)
    result == 1

# root of 4
expect
    result = square_root(4)
    result == 2

# root of 25
expect
    result = square_root(25)
    result == 5

# root of 81
expect
    result = square_root(81)
    result == 9

# root of 196
expect
    result = square_root(196)
    result == 14

# root of 65025
expect
    result = square_root(65025)
    result == 255

