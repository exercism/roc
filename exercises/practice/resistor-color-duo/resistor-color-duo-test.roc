# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color-duo/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import ResistorColorDuo exposing [value]

# Brown and black
expect
    result = value(Brown, Black)
    result == 10

# Blue and grey
expect
    result = value(Blue, Grey)
    result == 68

# Yellow and violet
expect
    result = value(Yellow, Violet)
    result == 47

# White and red
expect
    result = value(White, Red)
    result == 92

# Orange and orange
expect
    result = value(Orange, Orange)
    result == 33

# Black and brown, one-digit
expect
    result = value(Black, Brown)
    result == 1

