# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/square-root/canonical-data.json
# File last updated on 2024-08-29
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
}

main! = \_args ->
    Ok {}

import SquareRoot exposing [square_root]

# root of 1
expect
    result = square_root 1
    result == 1

# root of 4
expect
    result = square_root 4
    result == 2

# root of 25
expect
    result = square_root 25
    result == 5

# root of 81
expect
    result = square_root 81
    result == 9

# root of 196
expect
    result = square_root 196
    result == 14

# root of 65025
expect
    result = square_root 65025
    result == 255

