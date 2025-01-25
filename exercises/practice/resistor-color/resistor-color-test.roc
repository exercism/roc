# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/bi5zubJ-_Hva9vxxPq4kNx4WHX6oFs8OP6Ad0tCYlrY.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import ResistorColor exposing [color_code, colors]

##
## Color codes
##

# Black
expect
    result = color_code("black")
    result == Ok(0)

# White
expect
    result = color_code("white")
    result == Ok(9)

# Orange
expect
    result = color_code("orange")
    result == Ok(3)

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
