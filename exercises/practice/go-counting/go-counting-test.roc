# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/go-counting/canonical-data.json
# File last updated on 2024-10-07
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import GoCounting exposing [territory, territories]

## The following two comparison functions are temporary workarounds for Roc issue #7144:
## comparing tags or records containing sets sometimes returns the wrong result
## depending on the internal order of the set data, so we have to unwrap the sets
## in order to compare them properly.
compareTerritory = \maybeResult, maybeExpected ->
    when (maybeResult, maybeExpected) is
        (Ok result, Ok expected) -> result.owner == expected.owner && result.territory == expected.territory
        _ -> Bool.false

compareTerritories = \maybeResult, maybeExpected ->
    when (maybeResult, maybeExpected) is
        (Ok result, Ok expected) -> result.black == expected.black && result.white == expected.white && result.none == expected.none
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
        |> Str.replaceEach "·" " "
    result = board |> territory { x: 0, y: 1 }
    expected = Ok {
        owner: Black,
        territory: Set.fromList [
            { x: 0, y: 0 },
            { x: 0, y: 1 },
            { x: 1, y: 0 },
        ],
    }
    result |> compareTerritory expected

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
        |> Str.replaceEach "·" " "
    result = board |> territory { x: 2, y: 3 }
    expected = Ok {
        owner: White,
        territory: Set.fromList [
            { x: 2, y: 3 },
        ],
    }
    result |> compareTerritory expected

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
        |> Str.replaceEach "·" " "
    result = board |> territory { x: 1, y: 4 }
    expected = Ok {
        owner: None,
        territory: Set.fromList [
            { x: 0, y: 3 },
            { x: 0, y: 4 },
            { x: 1, y: 4 },
        ],
    }
    result |> compareTerritory expected

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
        |> Str.replaceEach "·" " "
    result = board |> territory { x: 1, y: 1 }
    expected = Ok {
        owner: None,
        territory: Set.empty {},
    }
    result |> compareTerritory expected

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
        |> Str.replaceEach "·" " "
    result = board |> territory { x: 5, y: 1 }
    result |> Result.isErr

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
        |> Str.replaceEach "·" " "
    result = board |> territory { x: 1, y: 5 }
    result |> Result.isErr

# One territory is the whole board
expect
    board = "·" |> Str.replaceEach "·" " "
    result = board |> territories
    expected = Ok {
        black: Set.empty {},
        white: Set.empty {},
        none: Set.fromList [
            { x: 0, y: 0 },
        ],
    }
    result |> compareTerritories expected

# Two territory rectangular board
expect
    board =
        """
        ·BW·
        ·BW·
        """
        |> Str.replaceEach "·" " "
    result = board |> territories
    expected = Ok {
        black: Set.fromList [
            { x: 0, y: 0 },
            { x: 0, y: 1 },
        ],
        white: Set.fromList [
            { x: 3, y: 0 },
            { x: 3, y: 1 },
        ],
        none: Set.empty {},
    }
    result |> compareTerritories expected

# Two region rectangular board
expect
    board = "·B·" |> Str.replaceEach "·" " "
    result = board |> territories
    expected = Ok {
        black: Set.fromList [
            { x: 0, y: 0 },
            { x: 2, y: 0 },
        ],
        white: Set.empty {},
        none: Set.empty {},
    }
    result |> compareTerritories expected

