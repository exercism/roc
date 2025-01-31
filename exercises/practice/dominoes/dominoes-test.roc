# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/dominoes/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Dominoes exposing [find_chain]

Domino : (U8, U8)

## Rotate each domino if needed to ensure that the small side is on the left
canonicalize : List Domino -> List Domino
canonicalize = |dominoes|
    dominoes
    |> List.map(
        |domino|
            if domino.0 > domino.1 then (domino.1, domino.0) else domino,
    )

## Ensure that the given result is Ok and is a valid chain for the
## given list of dominoes
is_valid_chain_for : Result (List Domino) _, List Domino -> Bool
is_valid_chain_for = |maybe_chain, dominoes|
    when maybe_chain is
        Err(_) -> Bool.false
        Ok(chain) ->
            if Set.from_list(canonicalize(chain)) == Set.from_list(canonicalize(dominoes)) then
                when chain is
                    [] -> Bool.true
                    [.., last] ->
                        chain
                        |> List.walk_until(
                            Ok(last),
                            |state, domino|
                                when state is
                                    Err(InvalidChain) -> crash("Unreachable")
                                    Ok(previous) ->
                                        if previous.1 == domino.0 then
                                            Continue(Ok(domino))
                                        else
                                            Break(Err(InvalidChain)),
                        )
                        |> Result.is_ok
            else
                Bool.false

# empty input = empty output
expect
    result = find_chain([])
    result |> is_valid_chain_for([])

# singleton input = singleton output
expect
    result = find_chain([(1, 1)])
    result |> is_valid_chain_for([(1, 1)])

# singleton that can't be chained
expect
    result = find_chain([(1, 2)])
    result |> Result.is_err

# three elements
expect
    result = find_chain([(1, 2), (3, 1), (2, 3)])
    result |> is_valid_chain_for([(1, 2), (3, 1), (2, 3)])

# can reverse dominoes
expect
    result = find_chain([(1, 2), (1, 3), (2, 3)])
    result |> is_valid_chain_for([(1, 2), (1, 3), (2, 3)])

# can't be chained
expect
    result = find_chain([(1, 2), (4, 1), (2, 3)])
    result |> Result.is_err

# disconnected - simple
expect
    result = find_chain([(1, 1), (2, 2)])
    result |> Result.is_err

# disconnected - double loop
expect
    result = find_chain([(1, 2), (2, 1), (3, 4), (4, 3)])
    result |> Result.is_err

# disconnected - single isolated
expect
    result = find_chain([(1, 2), (2, 3), (3, 1), (4, 4)])
    result |> Result.is_err

# need backtrack
expect
    result = find_chain([(1, 2), (2, 3), (3, 1), (2, 4), (2, 4)])
    result |> is_valid_chain_for([(1, 2), (2, 3), (3, 1), (2, 4), (2, 4)])

# separate loops
expect
    result = find_chain([(1, 2), (2, 3), (3, 1), (1, 1), (2, 2), (3, 3)])
    result |> is_valid_chain_for([(1, 2), (2, 3), (3, 1), (1, 1), (2, 2), (3, 3)])

# nine elements
expect
    result = find_chain([(1, 2), (5, 3), (3, 1), (1, 2), (2, 4), (1, 6), (2, 3), (3, 4), (5, 6)])
    result |> is_valid_chain_for([(1, 2), (5, 3), (3, 1), (1, 2), (2, 4), (1, 6), (2, 3), (3, 4), (5, 6)])

# separate three-domino loops
expect
    result = find_chain([(1, 2), (2, 3), (3, 1), (4, 5), (5, 6), (6, 4)])
    result |> Result.is_err

