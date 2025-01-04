# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/accumulate/canonical-data.json
# File last updated on 2024-09-15
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
}

main! = \_args ->
    Ok {}

import Accumulate exposing [accumulate]

# accumulate empty
expect
    result = accumulate [] \x ->
        x * x
    result == []

# accumulate squares
expect
    result = accumulate [1, 2, 3] \x ->
        x * x
    result == [1, 4, 9]

# accumulate upcases
expect
    result = accumulate ["Hello", "world"] to_upper
    result == ["HELLO", "WORLD"]

# accumulate reversed strings
expect
    result = accumulate ["the", "quick", "brown", "fox", "etc"] reverse
    result == ["eht", "kciuq", "nworb", "xof", "cte"]

# accumulate recursively
expect
    result = accumulate ["a", "b", "c"] \x ->
        accumulate ["1", "2", "3"] (\y -> Str.concat x y)
    result == [["a1", "a2", "a3"], ["b1", "b2", "b3"], ["c1", "c2", "c3"]]

reverse : Str -> Str
reverse = \str ->
    Str.toUtf8 str
    |> List.reverse
    |> Str.fromUtf8
    |> Result.withDefault ""

to_upper : Str -> Str
to_upper = \str ->
    Str.toUtf8 str
    |> List.map \byte ->
        if 'a' <= byte && byte <= 'z' then
            byte - 'a' + 'A'
        else
            byte
    |> Str.fromUtf8
    |> Result.withDefault ""
