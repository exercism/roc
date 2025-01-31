# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/flatten-array/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import FlattenArray exposing [flatten]

# empty
expect
    result = flatten(
        NestedArray(
            [
            ],
        ),
    )
    result == []

# no nesting
expect
    result = flatten(
        NestedArray(
            [
                Value(0),
                Value(1),
                Value(2),
            ],
        ),
    )
    result == [0, 1, 2]

# flattens a nested array
expect
    result = flatten(
        NestedArray(
            [
                NestedArray(
                    [
                        NestedArray(
                            [
                            ],
                        ),
                    ],
                ),
            ],
        ),
    )
    result == []

# flattens array with just integers present
expect
    result = flatten(
        NestedArray(
            [
                Value(1),
                NestedArray(
                    [
                        Value(2),
                        Value(3),
                        Value(4),
                        Value(5),
                        Value(6),
                        Value(7),
                    ],
                ),
                Value(8),
            ],
        ),
    )
    result == [1, 2, 3, 4, 5, 6, 7, 8]

# 5 level nesting
expect
    result = flatten(
        NestedArray(
            [
                Value(0),
                Value(2),
                NestedArray(
                    [
                        NestedArray(
                            [
                                Value(2),
                                Value(3),
                            ],
                        ),
                        Value(8),
                        Value(100),
                        Value(4),
                        NestedArray(
                            [
                                NestedArray(
                                    [
                                        NestedArray(
                                            [
                                                Value(50),
                                            ],
                                        ),
                                    ],
                                ),
                            ],
                        ),
                    ],
                ),
                Value(-2),
            ],
        ),
    )
    result == [0, 2, 2, 3, 8, 100, 4, 50, -2]

# 6 level nesting
expect
    result = flatten(
        NestedArray(
            [
                Value(1),
                NestedArray(
                    [
                        Value(2),
                        NestedArray(
                            [
                                NestedArray(
                                    [
                                        Value(3),
                                    ],
                                ),
                            ],
                        ),
                        NestedArray(
                            [
                                Value(4),
                                NestedArray(
                                    [
                                        NestedArray(
                                            [
                                                Value(5),
                                            ],
                                        ),
                                    ],
                                ),
                            ],
                        ),
                        Value(6),
                        Value(7),
                    ],
                ),
                Value(8),
            ],
        ),
    )
    result == [1, 2, 3, 4, 5, 6, 7, 8]

# null values are omitted from the final result
expect
    result = flatten(
        NestedArray(
            [
                Value(1),
                Value(2),
                Null,
            ],
        ),
    )
    result == [1, 2]

# consecutive null values at the front of the list are omitted from the final result
expect
    result = flatten(
        NestedArray(
            [
                Null,
                Null,
                Value(3),
            ],
        ),
    )
    result == [3]

# consecutive null values in the middle of the list are omitted from the final result
expect
    result = flatten(
        NestedArray(
            [
                Value(1),
                Null,
                Null,
                Value(4),
            ],
        ),
    )
    result == [1, 4]

# 6 level nest list with null values
expect
    result = flatten(
        NestedArray(
            [
                Value(0),
                Value(2),
                NestedArray(
                    [
                        NestedArray(
                            [
                                Value(2),
                                Value(3),
                            ],
                        ),
                        Value(8),
                        NestedArray(
                            [
                                NestedArray(
                                    [
                                        Value(100),
                                    ],
                                ),
                            ],
                        ),
                        Null,
                        NestedArray(
                            [
                                NestedArray(
                                    [
                                        Null,
                                    ],
                                ),
                            ],
                        ),
                    ],
                ),
                Value(-2),
            ],
        ),
    )
    result == [0, 2, 2, 3, 8, 100, -2]

# all values in nested list are null
expect
    result = flatten(
        NestedArray(
            [
                Null,
                NestedArray(
                    [
                        NestedArray(
                            [
                                NestedArray(
                                    [
                                        Null,
                                    ],
                                ),
                            ],
                        ),
                    ],
                ),
                Null,
                Null,
                NestedArray(
                    [
                        NestedArray(
                            [
                                Null,
                                Null,
                            ],
                        ),
                        Null,
                    ],
                ),
                Null,
            ],
        ),
    )
    result == []

