# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import ResistorColor exposing [colorCode, colors]

##
## Color codes
##

# Black
expect
    result = colorCode "black"
    result == Ok 0

# White
expect
    result = colorCode "white"
    result == Ok 9

# Orange
expect
    result = colorCode "orange"
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
