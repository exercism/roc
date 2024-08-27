# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color-duo/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import ResistorColorDuo exposing [value]

# Brown and black
expect
    result = value ["brown", "black"]
    result == Ok 10

# Blue and grey
expect
    result = value ["blue", "grey"]
    result == Ok 68

# Yellow and violet
expect
    result = value ["yellow", "violet"]
    result == Ok 47

# White and red
expect
    result = value ["white", "red"]
    result == Ok 92

# Orange and orange
expect
    result = value ["orange", "orange"]
    result == Ok 33

# Ignore additional colors
expect
    result = value ["green", "brown", "orange"]
    result == Ok 51

# Black and brown, one-digit
expect
    result = value ["black", "brown"]
    result == Ok 1

