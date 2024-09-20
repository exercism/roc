# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/matrix/canonical-data.json
# File last updated on 2024-09-20
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Matrix exposing [row, column]

# extract row from one number matrix
expect
    matrixStr = "1"
    result = matrixStr |> row 1
    result == Ok [1]

# can extract row
expect
    matrixStr =
        """
        1 2
        3 4
        """
    result = matrixStr |> row 2
    result == Ok [3, 4]

# extract row where numbers have different widths
expect
    matrixStr =
        """
        1 2
        10 20
        """
    result = matrixStr |> row 2
    result == Ok [10, 20]

# can extract row from non-square matrix with no corresponding column
expect
    matrixStr =
        """
        1 2 3
        4 5 6
        7 8 9
        8 7 6
        """
    result = matrixStr |> row 4
    result == Ok [8, 7, 6]

# extract column from one number matrix
expect
    matrixStr = "1"
    result = matrixStr |> column 1
    result == Ok [1]

# can extract column
expect
    matrixStr =
        """
        1 2 3
        4 5 6
        7 8 9
        """
    result = matrixStr |> column 3
    result == Ok [3, 6, 9]

# can extract column from non-square matrix with no corresponding row
expect
    matrixStr =
        """
        1 2 3 4
        5 6 7 8
        9 8 7 6
        """
    result = matrixStr |> column 4
    result == Ok [4, 8, 6]

# extract column where numbers have different widths
expect
    matrixStr =
        """
        89 1903 3
        18 3 1
        9 4 800
        """
    result = matrixStr |> column 2
    result == Ok [1903, 3, 4]

