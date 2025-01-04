# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pythagorean-triplet/canonical-data.json
# File last updated on 2024-10-10
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
}

main! = \_args ->
    Ok {}

import PythagoreanTriplet exposing [triplets_with_sum]

# triplets whose sum is 12
expect
    result = triplets_with_sum 12
    expected = Set.fromList [
        (3, 4, 5),
    ]
    result == expected

# triplets whose sum is 108
expect
    result = triplets_with_sum 108
    expected = Set.fromList [
        (27, 36, 45),
    ]
    result == expected

# triplets whose sum is 1000
expect
    result = triplets_with_sum 1000
    expected = Set.fromList [
        (200, 375, 425),
    ]
    result == expected

# no matching triplets for 1001
expect
    result = triplets_with_sum 1001
    expected = Set.fromList []
    result == expected

# returns all matching triplets
expect
    result = triplets_with_sum 90
    expected = Set.fromList [
        (9, 40, 41),
        (15, 36, 39),
    ]
    result == expected

# several matching triplets
expect
    result = triplets_with_sum 840
    expected = Set.fromList [
        (40, 399, 401),
        (56, 390, 394),
        (105, 360, 375),
        (120, 350, 370),
        (140, 336, 364),
        (168, 315, 357),
        (210, 280, 350),
        (240, 252, 348),
    ]
    result == expected

# triplets for large number
expect
    result = triplets_with_sum 30000
    expected = Set.fromList [
        (1200, 14375, 14425),
        (1875, 14000, 14125),
        (5000, 12000, 13000),
        (6000, 11250, 12750),
        (7500, 10000, 12500),
    ]
    result == expected

