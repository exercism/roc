# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/palindrome-products/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import PalindromeProducts exposing [smallest, largest]

is_eq = |result, expected|
    when (result, expected) is
        (Ok({ value, factors }), Ok({ value: expected_value, factors: expected_factors })) ->
            value == expected_value and factors == expected_factors

        _ -> Bool.false

# find the smallest palindrome from single digit factors
expect
    result = smallest({ min: 1, max: 9 })
    expected = Ok(
        {
            value: 1,
            factors: Set.from_list(
                [
                    (1, 1),
                ],
            ),
        },
    )
    result |> is_eq(expected)

# find the largest palindrome from single digit factors
expect
    result = largest({ min: 1, max: 9 })
    expected = Ok(
        {
            value: 9,
            factors: Set.from_list(
                [
                    (1, 9),
                    (3, 3),
                ],
            ),
        },
    )
    result |> is_eq(expected)

# find the smallest palindrome from double digit factors
expect
    result = smallest({ min: 10, max: 99 })
    expected = Ok(
        {
            value: 121,
            factors: Set.from_list(
                [
                    (11, 11),
                ],
            ),
        },
    )
    result |> is_eq(expected)

# find the largest palindrome from double digit factors
expect
    result = largest({ min: 10, max: 99 })
    expected = Ok(
        {
            value: 9009,
            factors: Set.from_list(
                [
                    (91, 99),
                ],
            ),
        },
    )
    result |> is_eq(expected)

# find the smallest palindrome from triple digit factors
expect
    result = smallest({ min: 100, max: 999 })
    expected = Ok(
        {
            value: 10201,
            factors: Set.from_list(
                [
                    (101, 101),
                ],
            ),
        },
    )
    result |> is_eq(expected)

# find the largest palindrome from triple digit factors
expect
    result = largest({ min: 100, max: 999 })
    expected = Ok(
        {
            value: 906609,
            factors: Set.from_list(
                [
                    (913, 993),
                ],
            ),
        },
    )
    result |> is_eq(expected)

# find the smallest palindrome from four digit factors
expect
    result = smallest({ min: 1000, max: 9999 })
    expected = Ok(
        {
            value: 1002001,
            factors: Set.from_list(
                [
                    (1001, 1001),
                ],
            ),
        },
    )
    result |> is_eq(expected)

# find the largest palindrome from four digit factors
expect
    result = largest({ min: 1000, max: 9999 })
    expected = Ok(
        {
            value: 99000099,
            factors: Set.from_list(
                [
                    (9901, 9999),
                ],
            ),
        },
    )
    result |> is_eq(expected)

# empty result for smallest if no palindrome in the range
expect
    result = smallest({ min: 1002, max: 1003 })
    expected = Ok(
        {
            value: 0,
            factors: Set.from_list(
                [
                ],
            ),
        },
    )
    result |> is_eq(expected)

# empty result for largest if no palindrome in the range
expect
    result = largest({ min: 15, max: 15 })
    expected = Ok(
        {
            value: 0,
            factors: Set.from_list(
                [
                ],
            ),
        },
    )
    result |> is_eq(expected)

# error result for smallest if min is more than max
expect
    result = smallest({ min: 10000, max: 1 })
    result |> Result.is_err

# error result for largest if min is more than max
expect
    result = largest({ min: 2, max: 1 })
    result |> Result.is_err

# smallest product does not use the smallest factor
expect
    result = smallest({ min: 3215, max: 4000 })
    expected = Ok(
        {
            value: 10988901,
            factors: Set.from_list(
                [
                    (3297, 3333),
                ],
            ),
        },
    )
    result |> is_eq(expected)

