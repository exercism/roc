# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/spiral-matrix/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import SpiralMatrix exposing [spiral_matrix]

# empty spiral
expect
    result = spiral_matrix(0)
    result == []

# trivial spiral
expect
    result = spiral_matrix(1)
    expected = [
        [1],
    ]
    result == expected

# spiral of size 2
expect
    result = spiral_matrix(2)
    expected = [
        [1, 2],
        [4, 3],
    ]
    result == expected

# spiral of size 3
expect
    result = spiral_matrix(3)
    expected = [
        [1, 2, 3],
        [8, 9, 4],
        [7, 6, 5],
    ]
    result == expected

# spiral of size 4
expect
    result = spiral_matrix(4)
    expected = [
        [1, 2, 3, 4],
        [12, 13, 14, 5],
        [11, 16, 15, 6],
        [10, 9, 8, 7],
    ]
    result == expected

# spiral of size 5
expect
    result = spiral_matrix(5)
    expected = [
        [1, 2, 3, 4, 5],
        [16, 17, 18, 19, 6],
        [15, 24, 25, 20, 7],
        [14, 23, 22, 21, 8],
        [13, 12, 11, 10, 9],
    ]
    result == expected

