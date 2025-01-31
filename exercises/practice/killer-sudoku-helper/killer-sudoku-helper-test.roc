# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/killer-sudoku-helper/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import KillerSudokuHelper exposing [combinations]

## Trivial 1-digit cages
# 1
expect
    result = combinations({ sum: 1, size: 1 })
    result == [[1]]

# 2
expect
    result = combinations({ sum: 2, size: 1 })
    result == [[2]]

# 3
expect
    result = combinations({ sum: 3, size: 1 })
    result == [[3]]

# 4
expect
    result = combinations({ sum: 4, size: 1 })
    result == [[4]]

# 5
expect
    result = combinations({ sum: 5, size: 1 })
    result == [[5]]

# 6
expect
    result = combinations({ sum: 6, size: 1 })
    result == [[6]]

# 7
expect
    result = combinations({ sum: 7, size: 1 })
    result == [[7]]

# 8
expect
    result = combinations({ sum: 8, size: 1 })
    result == [[8]]

# 9
expect
    result = combinations({ sum: 9, size: 1 })
    result == [[9]]

## Cage with sum 45 contains all digits 1:9
expect
    result = combinations({ sum: 45, size: 9 })
    result == [[1, 2, 3, 4, 5, 6, 7, 8, 9]]

## Cage with only 1 possible combination
expect
    result = combinations({ sum: 7, size: 3 })
    result == [[1, 2, 4]]

## Cage with several combinations
expect
    result = combinations({ sum: 10, size: 2 })
    result == [[1, 9], [2, 8], [3, 7], [4, 6]]

## Cage with several combinations that is restricted
expect
    result = combinations({ sum: 10, size: 2, exclude: [1, 4] })
    result == [[2, 8], [3, 7]]

