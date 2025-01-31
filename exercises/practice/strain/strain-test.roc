# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/strain/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Strain exposing [keep, discard]

# keep on empty list returns empty list
expect
    list = []
    result = list |> keep(|_| Bool.true)
    expected = []
    result == expected

# keeps everything
expect
    list = [1, 3, 5]
    result = list |> keep(|_| Bool.true)
    expected = [1, 3, 5]
    result == expected

# keeps nothing
expect
    list = [1, 3, 5]
    result = list |> keep(|_| Bool.false)
    expected = []
    result == expected

# keeps first and last
expect
    list = [1, 2, 3]
    result = list |> keep(|x| x % 2 == 1)
    expected = [1, 3]
    result == expected

# keeps neither first nor last
expect
    list = [1, 2, 3]
    result = list |> keep(|x| x % 2 == 0)
    expected = [2]
    result == expected

# keeps strings
expect
    list = ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"]
    result = list |> keep(|x| x |> Str.starts_with("z"))
    expected = ["zebra", "zombies", "zealot"]
    result == expected

# keeps lists
expect
    list = [[1, 2, 3], [5, 5, 5], [5, 1, 2], [2, 1, 2], [1, 5, 2], [2, 2, 1], [1, 2, 5]]
    result = list |> keep(|x| x |> List.contains(5))
    expected = [[5, 5, 5], [5, 1, 2], [1, 5, 2], [1, 2, 5]]
    result == expected

# discard on empty list returns empty list
expect
    list = []
    result = list |> discard(|_| Bool.true)
    expected = []
    result == expected

# discards everything
expect
    list = [1, 3, 5]
    result = list |> discard(|_| Bool.true)
    expected = []
    result == expected

# discards nothing
expect
    list = [1, 3, 5]
    result = list |> discard(|_| Bool.false)
    expected = [1, 3, 5]
    result == expected

# discards first and last
expect
    list = [1, 2, 3]
    result = list |> discard(|x| x % 2 == 1)
    expected = [2]
    result == expected

# discards neither first nor last
expect
    list = [1, 2, 3]
    result = list |> discard(|x| x % 2 == 0)
    expected = [1, 3]
    result == expected

# discards strings
expect
    list = ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"]
    result = list |> discard(|x| x |> Str.starts_with("z"))
    expected = ["apple", "banana", "cherimoya"]
    result == expected

# discards lists
expect
    list = [[1, 2, 3], [5, 5, 5], [5, 1, 2], [2, 1, 2], [1, 5, 2], [2, 2, 1], [1, 2, 5]]
    result = list |> discard(|x| x |> List.contains(5))
    expected = [[1, 2, 3], [2, 1, 2], [2, 2, 1]]
    result == expected

