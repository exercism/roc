# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/etl/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Etl exposing [transform]

# single letter
expect
    legacy =
        Dict.from_list(
            [
                (1, ['A']),
            ],
        )
    expected =
        Dict.from_list(
            [
                ('a', 1),
            ],
        )
    transform(legacy) == expected

# single score with multiple letters
expect
    legacy =
        Dict.from_list(
            [
                (1, ['A', 'E', 'I', 'O', 'U']),
            ],
        )
    expected =
        Dict.from_list(
            [
                ('a', 1),
                ('e', 1),
                ('i', 1),
                ('o', 1),
                ('u', 1),
            ],
        )
    transform(legacy) == expected

# multiple scores with multiple letters
expect
    legacy =
        Dict.from_list(
            [
                (1, ['A', 'E']),
                (2, ['D', 'G']),
            ],
        )
    expected =
        Dict.from_list(
            [
                ('a', 1),
                ('d', 2),
                ('e', 1),
                ('g', 2),
            ],
        )
    transform(legacy) == expected

# multiple scores with differing numbers of letters
expect
    legacy =
        Dict.from_list(
            [
                (1, ['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T']),
                (2, ['D', 'G']),
                (3, ['B', 'C', 'M', 'P']),
                (4, ['F', 'H', 'V', 'W', 'Y']),
                (5, ['K']),
                (8, ['J', 'X']),
                (10, ['Q', 'Z']),
            ],
        )
    expected =
        Dict.from_list(
            [
                ('a', 1),
                ('b', 3),
                ('c', 3),
                ('d', 2),
                ('e', 1),
                ('f', 4),
                ('g', 2),
                ('h', 4),
                ('i', 1),
                ('j', 8),
                ('k', 5),
                ('l', 1),
                ('m', 3),
                ('n', 1),
                ('o', 1),
                ('p', 3),
                ('q', 10),
                ('r', 1),
                ('s', 1),
                ('t', 1),
                ('u', 1),
                ('v', 4),
                ('w', 4),
                ('x', 8),
                ('y', 4),
                ('z', 10),
            ],
        )
    transform(legacy) == expected

