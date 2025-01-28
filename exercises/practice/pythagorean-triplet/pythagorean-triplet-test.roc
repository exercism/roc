# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pythagorean-triplet/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import PythagoreanTriplet exposing [triplets_with_sum]

# triplets whose sum is 12
expect
    result = triplets_with_sum(12)
    expected = Set.from_list(
        [
            (3, 4, 5),
        ],
    )
    result == expected

# triplets whose sum is 108
expect
    result = triplets_with_sum(108)
    expected = Set.from_list(
        [
            (27, 36, 45),
        ],
    )
    result == expected

# triplets whose sum is 1000
expect
    result = triplets_with_sum(1000)
    expected = Set.from_list(
        [
            (200, 375, 425),
        ],
    )
    result == expected

# no matching triplets for 1001
expect
    result = triplets_with_sum(1001)
    expected = Set.from_list([])
    result == expected

# returns all matching triplets
expect
    result = triplets_with_sum(90)
    expected = Set.from_list(
        [
            (9, 40, 41),
            (15, 36, 39),
        ],
    )
    result == expected

# several matching triplets
expect
    result = triplets_with_sum(840)
    expected = Set.from_list(
        [
            (40, 399, 401),
            (56, 390, 394),
            (105, 360, 375),
            (120, 350, 370),
            (140, 336, 364),
            (168, 315, 357),
            (210, 280, 350),
            (240, 252, 348),
        ],
    )
    result == expected

# triplets for large number
expect
    result = triplets_with_sum(30000)
    expected = Set.from_list(
        [
            (1200, 14375, 14425),
            (1875, 14000, 14125),
            (5000, 12000, 13000),
            (6000, 11250, 12750),
            (7500, 10000, 12500),
        ],
    )
    result == expected

