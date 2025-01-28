# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/change/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Change exposing [find_fewest_coins]

# change for 1 cent
expect
    coins = [1, 5, 10, 25]
    result = coins |> find_fewest_coins(1)
    result == Ok([1])

# single coin change
expect
    coins = [1, 5, 10, 25, 100]
    result = coins |> find_fewest_coins(25)
    result == Ok([25])

# multiple coin change
expect
    coins = [1, 5, 10, 25, 100]
    result = coins |> find_fewest_coins(15)
    result == Ok([5, 10])

# change with Lilliputian Coins
expect
    coins = [1, 4, 15, 20, 50]
    result = coins |> find_fewest_coins(23)
    result == Ok([4, 4, 15])

# change with Lower Elbonia Coins
expect
    coins = [1, 5, 10, 21, 25]
    result = coins |> find_fewest_coins(63)
    result == Ok([21, 21, 21])

# large target values
expect
    coins = [1, 2, 5, 10, 20, 50, 100]
    result = coins |> find_fewest_coins(999)
    result == Ok([2, 2, 5, 20, 20, 50, 100, 100, 100, 100, 100, 100, 100, 100, 100])

# possible change without unit coins available
expect
    coins = [2, 5, 10, 20, 50]
    result = coins |> find_fewest_coins(21)
    result == Ok([2, 2, 2, 5, 10])

# another possible change without unit coins available
expect
    coins = [4, 5]
    result = coins |> find_fewest_coins(27)
    result == Ok([4, 4, 4, 5, 5, 5])

# a greedy approach is not optimal
expect
    coins = [1, 10, 11]
    result = coins |> find_fewest_coins(20)
    result == Ok([10, 10])

# no coins make 0 change
expect
    coins = [1, 5, 10, 21, 25]
    result = coins |> find_fewest_coins(0)
    result == Ok([])

# error testing for change smaller than the smallest of coins
expect
    coins = [5, 10]
    result = coins |> find_fewest_coins(3)
    result |> Result.is_err

# error if no combination can add up to target
expect
    coins = [5, 10]
    result = coins |> find_fewest_coins(94)
    result |> Result.is_err

