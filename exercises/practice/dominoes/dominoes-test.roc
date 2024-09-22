# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/dominoes/canonical-data.json
# File last updated on 2024-09-21
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Dominoes exposing [findChain]

Domino : (U8, U8)

## Rotate each domino if needed to ensure that the small side is on the left
canonicalize : List Domino -> List Domino
canonicalize = \dominoes ->
    dominoes
    |> List.map \domino ->
        if domino.0 > domino.1 then (domino.1, domino.0) else domino

## Ensure that the given result is Ok and is a valid chain for the
## given list of dominoes
isValidChainFor : Result (List Domino) _, List Domino -> Bool
isValidChainFor = \maybeChain, dominoes ->
    when maybeChain is
        Err _ -> Bool.false
        Ok chain ->
            if Set.fromList (canonicalize chain) == Set.fromList (canonicalize dominoes) then
                when chain is
                    [] -> Bool.true
                    [.., last] ->
                        chain
                        |> List.walkUntil (Ok last) \state, domino ->
                            when state is
                                Err InvalidChain -> crash "Unreachable"
                                Ok previous ->
                                    if previous.1 == domino.0 then
                                        Continue (Ok domino)
                                    else
                                        Break (Err InvalidChain)
                        |> Result.isOk
            else
                Bool.false

# empty input = empty output
expect
    result = findChain []
    result |> isValidChainFor []

# singleton input = singleton output
expect
    result = findChain [(1, 1)]
    result |> isValidChainFor [(1, 1)]

# singleton that can't be chained
expect
    result = findChain [(1, 2)]
    result |> Result.isErr

# three elements
expect
    result = findChain [(1, 2), (3, 1), (2, 3)]
    result |> isValidChainFor [(1, 2), (3, 1), (2, 3)]

# can reverse dominoes
expect
    result = findChain [(1, 2), (1, 3), (2, 3)]
    result |> isValidChainFor [(1, 2), (1, 3), (2, 3)]

# can't be chained
expect
    result = findChain [(1, 2), (4, 1), (2, 3)]
    result |> Result.isErr

# disconnected - simple
expect
    result = findChain [(1, 1), (2, 2)]
    result |> Result.isErr

# disconnected - double loop
expect
    result = findChain [(1, 2), (2, 1), (3, 4), (4, 3)]
    result |> Result.isErr

# disconnected - single isolated
expect
    result = findChain [(1, 2), (2, 3), (3, 1), (4, 4)]
    result |> Result.isErr

# need backtrack
expect
    result = findChain [(1, 2), (2, 3), (3, 1), (2, 4), (2, 4)]
    result |> isValidChainFor [(1, 2), (2, 3), (3, 1), (2, 4), (2, 4)]

# separate loops
expect
    result = findChain [(1, 2), (2, 3), (3, 1), (1, 1), (2, 2), (3, 3)]
    result |> isValidChainFor [(1, 2), (2, 3), (3, 1), (1, 1), (2, 2), (3, 3)]

# nine elements
expect
    result = findChain [(1, 2), (5, 3), (3, 1), (1, 2), (2, 4), (1, 6), (2, 3), (3, 4), (5, 6)]
    result |> isValidChainFor [(1, 2), (5, 3), (3, 1), (1, 2), (2, 4), (1, 6), (2, 3), (3, 4), (5, 6)]

# separate three-domino loops
expect
    result = findChain [(1, 2), (2, 3), (3, 1), (4, 5), (5, 6), (6, 4)]
    result |> Result.isErr

