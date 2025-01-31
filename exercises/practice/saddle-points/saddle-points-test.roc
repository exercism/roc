# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/saddle-points/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import SaddlePoints exposing [saddle_points]

# Can identify single saddle point
expect
    tree_heights = [
        [9, 8, 7],
        [5, 3, 2],
        [6, 6, 7],
    ]
    result = tree_heights |> saddle_points
    expected = Set.from_list(
        [
            { row: 2, column: 1 },
        ],
    )
    result == expected

# Can identify that empty matrix has no saddle points
expect
    tree_heights = [
        [],
    ]
    result = tree_heights |> saddle_points
    expected = Set.from_list(
        [
        ],
    )
    result == expected

# Can identify lack of saddle points when there are none
expect
    tree_heights = [
        [1, 2, 3],
        [3, 1, 2],
        [2, 3, 1],
    ]
    result = tree_heights |> saddle_points
    expected = Set.from_list(
        [
        ],
    )
    result == expected

# Can identify multiple saddle points in a column
expect
    tree_heights = [
        [4, 5, 4],
        [3, 5, 5],
        [1, 5, 4],
    ]
    result = tree_heights |> saddle_points
    expected = Set.from_list(
        [
            { row: 1, column: 2 },
            { row: 2, column: 2 },
            { row: 3, column: 2 },
        ],
    )
    result == expected

# Can identify multiple saddle points in a row
expect
    tree_heights = [
        [6, 7, 8],
        [5, 5, 5],
        [7, 5, 6],
    ]
    result = tree_heights |> saddle_points
    expected = Set.from_list(
        [
            { row: 2, column: 1 },
            { row: 2, column: 2 },
            { row: 2, column: 3 },
        ],
    )
    result == expected

# Can identify saddle point in bottom right corner
expect
    tree_heights = [
        [8, 7, 9],
        [6, 7, 6],
        [3, 2, 5],
    ]
    result = tree_heights |> saddle_points
    expected = Set.from_list(
        [
            { row: 3, column: 3 },
        ],
    )
    result == expected

# Can identify saddle points in a non square matrix
expect
    tree_heights = [
        [3, 1, 3],
        [3, 2, 4],
    ]
    result = tree_heights |> saddle_points
    expected = Set.from_list(
        [
            { row: 1, column: 3 },
            { row: 1, column: 1 },
        ],
    )
    result == expected

# Can identify that saddle points in a single column matrix are those with the minimum value
expect
    tree_heights = [
        [2],
        [1],
        [4],
        [1],
    ]
    result = tree_heights |> saddle_points
    expected = Set.from_list(
        [
            { row: 2, column: 1 },
            { row: 4, column: 1 },
        ],
    )
    result == expected

# Can identify that saddle points in a single row matrix are those with the maximum value
expect
    tree_heights = [
        [2, 5, 3, 5],
    ]
    result = tree_heights |> saddle_points
    expected = Set.from_list(
        [
            { row: 1, column: 2 },
            { row: 1, column: 4 },
        ],
    )
    result == expected

