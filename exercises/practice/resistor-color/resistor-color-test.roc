# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
}

main! = \_args ->
    Ok {}

import ResistorColor exposing [color_code, colors]

##
## Color codes
##

# Black
expect
    result = color_code "black"
    result == Ok 0

# White
expect
    result = color_code "white"
    result == Ok 9

# Orange
expect
    result = color_code "orange"
    result == Ok 3

##
## Colors
##

expect
    result = colors
    result
    == [
        "black",
        "brown",
        "red",
        "orange",
        "yellow",
        "green",
        "blue",
        "violet",
        "grey",
        "white",
    ]
