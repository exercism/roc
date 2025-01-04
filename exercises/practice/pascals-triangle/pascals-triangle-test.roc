# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pascals-triangle/canonical-data.json
# File last updated on 2024-10-14
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
}

main! = \_args ->
    Ok {}

import PascalsTriangle exposing [pascals_triangle]

# zero rows
expect
    result = pascals_triangle 0
    expected = []
    result == expected

# single row
expect
    result = pascals_triangle 1
    expected = [
        [1],
    ]
    result == expected

# two rows
expect
    result = pascals_triangle 2
    expected = [
        [1],
        [1, 1],
    ]
    result == expected

# three rows
expect
    result = pascals_triangle 3
    expected = [
        [1],
        [1, 1],
        [1, 2, 1],
    ]
    result == expected

# four rows
expect
    result = pascals_triangle 4
    expected = [
        [1],
        [1, 1],
        [1, 2, 1],
        [1, 3, 3, 1],
    ]
    result == expected

# five rows
expect
    result = pascals_triangle 5
    expected = [
        [1],
        [1, 1],
        [1, 2, 1],
        [1, 3, 3, 1],
        [1, 4, 6, 4, 1],
    ]
    result == expected

# six rows
expect
    result = pascals_triangle 6
    expected = [
        [1],
        [1, 1],
        [1, 2, 1],
        [1, 3, 3, 1],
        [1, 4, 6, 4, 1],
        [1, 5, 10, 10, 5, 1],
    ]
    result == expected

# ten rows
expect
    result = pascals_triangle 10
    expected = [
        [1],
        [1, 1],
        [1, 2, 1],
        [1, 3, 3, 1],
        [1, 4, 6, 4, 1],
        [1, 5, 10, 10, 5, 1],
        [1, 6, 15, 20, 15, 6, 1],
        [1, 7, 21, 35, 35, 21, 7, 1],
        [1, 8, 28, 56, 70, 56, 28, 8, 1],
        [1, 9, 36, 84, 126, 126, 84, 36, 9, 1],
    ]
    result == expected

