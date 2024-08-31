# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/etl/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Etl exposing [transform]

# single letter
expect
    legacy =
        Dict.fromList [
            (1, ['A']),
        ]
    expected =
        Dict.fromList [
            ('a', 1),
        ]
    transform legacy == expected

# single score with multiple letters
expect
    legacy =
        Dict.fromList [
            (1, ['A', 'E', 'I', 'O', 'U']),
        ]
    expected =
        Dict.fromList [
            ('a', 1),
            ('e', 1),
            ('i', 1),
            ('o', 1),
            ('u', 1),
        ]
    transform legacy == expected

# multiple scores with multiple letters
expect
    legacy =
        Dict.fromList [
            (1, ['A', 'E']),
            (2, ['D', 'G']),
        ]
    expected =
        Dict.fromList [
            ('a', 1),
            ('d', 2),
            ('e', 1),
            ('g', 2),
        ]
    transform legacy == expected

# multiple scores with differing numbers of letters
expect
    legacy =
        Dict.fromList [
            (1, ['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T']),
            (2, ['D', 'G']),
            (3, ['B', 'C', 'M', 'P']),
            (4, ['F', 'H', 'V', 'W', 'Y']),
            (5, ['K']),
            (8, ['J', 'X']),
            (10, ['Q', 'Z']),
        ]
    expected =
        Dict.fromList [
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
        ]
    transform legacy == expected

