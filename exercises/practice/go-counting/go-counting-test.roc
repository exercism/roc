# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/go-counting/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import GoCounting exposing [territory, territories]

## The following two comparison functions are temporary workarounds for Roc issue #7144:
## comparing tags or records containing sets sometimes returns the wrong result
## depending on the internal order of the set data, so we have to unwrap the sets
## in order to compare them properly.
compare_territory = |maybe_result, maybe_expected|
    when (maybe_result, maybe_expected) is
        (Ok(result), Ok(expected)) -> result.owner == expected.owner and result.territory == expected.territory
        _ -> Bool.false

compare_territories = |maybe_result, maybe_expected|
    when (maybe_result, maybe_expected) is
        (Ok(result), Ok(expected)) -> result.black == expected.black and result.white == expected.white and result.none == expected.none
        _ -> Bool.false

# Black corner territory on 5x5 board
expect
    board =
        """
        ··B··
        ·B·B·
        B·W·B
        ·W·W·
        ··W··
        """
        |> Str.replace_each("·", " ")
    result = board |> territory({ x: 0, y: 1 })
    expected = Ok(
        {
            owner: Black,
            territory: Set.from_list(
                [
                    { x: 0, y: 0 },
                    { x: 0, y: 1 },
                    { x: 1, y: 0 },
                ],
            ),
        },
    )
    result |> compare_territory(expected)

# White center territory on 5x5 board
expect
    board =
        """
        ··B··
        ·B·B·
        B·W·B
        ·W·W·
        ··W··
        """
        |> Str.replace_each("·", " ")
    result = board |> territory({ x: 2, y: 3 })
    expected = Ok(
        {
            owner: White,
            territory: Set.from_list(
                [
                    { x: 2, y: 3 },
                ],
            ),
        },
    )
    result |> compare_territory(expected)

# Open corner territory on 5x5 board
expect
    board =
        """
        ··B··
        ·B·B·
        B·W·B
        ·W·W·
        ··W··
        """
        |> Str.replace_each("·", " ")
    result = board |> territory({ x: 1, y: 4 })
    expected = Ok(
        {
            owner: None,
            territory: Set.from_list(
                [
                    { x: 0, y: 3 },
                    { x: 0, y: 4 },
                    { x: 1, y: 4 },
                ],
            ),
        },
    )
    result |> compare_territory(expected)

# A stone and not a territory on 5x5 board
expect
    board =
        """
        ··B··
        ·B·B·
        B·W·B
        ·W·W·
        ··W··
        """
        |> Str.replace_each("·", " ")
    result = board |> territory({ x: 1, y: 1 })
    expected = Ok(
        {
            owner: None,
            territory: Set.empty({}),
        },
    )
    result |> compare_territory(expected)

# Invalid because X is too high for 5x5 board
expect
    board =
        """
        ··B··
        ·B·B·
        B·W·B
        ·W·W·
        ··W··
        """
        |> Str.replace_each("·", " ")
    result = board |> territory({ x: 5, y: 1 })
    result |> Result.is_err

# Invalid because Y is too high for 5x5 board
expect
    board =
        """
        ··B··
        ·B·B·
        B·W·B
        ·W·W·
        ··W··
        """
        |> Str.replace_each("·", " ")
    result = board |> territory({ x: 1, y: 5 })
    result |> Result.is_err

# One territory is the whole board
expect
    board = "·" |> Str.replace_each("·", " ")
    result = board |> territories
    expected = Ok(
        {
            black: Set.empty({}),

            white: Set.empty({}),

            none: Set.from_list(
                [
                    { x: 0, y: 0 },
                ],
            ),
        },
    )
    result |> compare_territories(expected)

# Two territory rectangular board
expect
    board =
        """
        ·BW·
        ·BW·
        """
        |> Str.replace_each("·", " ")
    result = board |> territories
    expected = Ok(
        {
            black: Set.from_list(
                [
                    { x: 0, y: 0 },
                    { x: 0, y: 1 },
                ],
            ),

            white: Set.from_list(
                [
                    { x: 3, y: 0 },
                    { x: 3, y: 1 },
                ],
            ),

            none: Set.empty({}),
        },
    )
    result |> compare_territories(expected)

# Two region rectangular board
expect
    board = "·B·" |> Str.replace_each("·", " ")
    result = board |> territories
    expected = Ok(
        {
            black: Set.from_list(
                [
                    { x: 0, y: 0 },
                    { x: 2, y: 0 },
                ],
            ),

            white: Set.empty({}),

            none: Set.empty({}),
        },
    )
    result |> compare_territories(expected)

