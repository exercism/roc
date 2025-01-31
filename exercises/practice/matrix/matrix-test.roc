# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/matrix/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Matrix exposing [row, column]

# extract row from one number matrix
expect
    matrix_str = "1"
    result = matrix_str |> row(1)
    result == Ok([1])

# can extract row
expect
    matrix_str =
        """
        1 2
        3 4
        """
    result = matrix_str |> row(2)
    result == Ok([3, 4])

# extract row where numbers have different widths
expect
    matrix_str =
        """
        1 2
        10 20
        """
    result = matrix_str |> row(2)
    result == Ok([10, 20])

# can extract row from non-square matrix with no corresponding column
expect
    matrix_str =
        """
        1 2 3
        4 5 6
        7 8 9
        8 7 6
        """
    result = matrix_str |> row(4)
    result == Ok([8, 7, 6])

# extract column from one number matrix
expect
    matrix_str = "1"
    result = matrix_str |> column(1)
    result == Ok([1])

# can extract column
expect
    matrix_str =
        """
        1 2 3
        4 5 6
        7 8 9
        """
    result = matrix_str |> column(3)
    result == Ok([3, 6, 9])

# can extract column from non-square matrix with no corresponding row
expect
    matrix_str =
        """
        1 2 3 4
        5 6 7 8
        9 8 7 6
        """
    result = matrix_str |> column(4)
    result == Ok([4, 8, 6])

# extract column where numbers have different widths
expect
    matrix_str =
        """
        89 1903 3
        18 3 1
        9 4 800
        """
    result = matrix_str |> column(2)
    result == Ok([1903, 3, 4])

