# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/palindrome-products/canonical-data.json
# File last updated on 2024-10-15
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import PalindromeProducts exposing [smallest, largest]

isEq = \result, expected ->
    when (result, expected) is
        (Ok { value, factors }, Ok { value: expectedValue, factors: expectedFactors }) ->
            value == expectedValue && factors == expectedFactors

        _ -> Bool.false

# find the smallest palindrome from single digit factors
expect
    result = smallest { min: 1, max: 9 }
    expected = Ok {
        value: 1,
        factors: Set.fromList [
            (1, 1),
        ],
    }
    result |> isEq expected

# find the largest palindrome from single digit factors
expect
    result = largest { min: 1, max: 9 }
    expected = Ok {
        value: 9,
        factors: Set.fromList [
            (1, 9),
            (3, 3),
        ],
    }
    result |> isEq expected

# find the smallest palindrome from double digit factors
expect
    result = smallest { min: 10, max: 99 }
    expected = Ok {
        value: 121,
        factors: Set.fromList [
            (11, 11),
        ],
    }
    result |> isEq expected

# find the largest palindrome from double digit factors
expect
    result = largest { min: 10, max: 99 }
    expected = Ok {
        value: 9009,
        factors: Set.fromList [
            (91, 99),
        ],
    }
    result |> isEq expected

# find the smallest palindrome from triple digit factors
expect
    result = smallest { min: 100, max: 999 }
    expected = Ok {
        value: 10201,
        factors: Set.fromList [
            (101, 101),
        ],
    }
    result |> isEq expected

# find the largest palindrome from triple digit factors
expect
    result = largest { min: 100, max: 999 }
    expected = Ok {
        value: 906609,
        factors: Set.fromList [
            (913, 993),
        ],
    }
    result |> isEq expected

# find the smallest palindrome from four digit factors
expect
    result = smallest { min: 1000, max: 9999 }
    expected = Ok {
        value: 1002001,
        factors: Set.fromList [
            (1001, 1001),
        ],
    }
    result |> isEq expected

# find the largest palindrome from four digit factors
expect
    result = largest { min: 1000, max: 9999 }
    expected = Ok {
        value: 99000099,
        factors: Set.fromList [
            (9901, 9999),
        ],
    }
    result |> isEq expected

# empty result for smallest if no palindrome in the range
expect
    result = smallest { min: 1002, max: 1003 }
    expected = Ok {
        value: 0,
        factors: Set.fromList [
        ],
    }
    result |> isEq expected

# empty result for largest if no palindrome in the range
expect
    result = largest { min: 15, max: 15 }
    expected = Ok {
        value: 0,
        factors: Set.fromList [
        ],
    }
    result |> isEq expected

# error result for smallest if min is more than max
expect
    result = smallest { min: 10000, max: 1 }
    result |> Result.isErr

# error result for largest if min is more than max
expect
    result = largest { min: 2, max: 1 }
    result |> Result.isErr

# smallest product does not use the smallest factor
expect
    result = smallest { min: 3215, max: 4000 }
    expected = Ok {
        value: 10988901,
        factors: Set.fromList [
            (3297, 3333),
        ],
    }
    result |> isEq expected

