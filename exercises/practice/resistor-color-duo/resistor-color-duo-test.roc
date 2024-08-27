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
expect value ["brown", "black"] == Ok 10

# Blue and grey
expect value ["blue", "grey"] == Ok 68

# Yellow and violet
expect value ["yellow", "violet"] == Ok 47

# White and red
expect value ["white", "red"] == Ok 92

# Orange and orange
expect value ["orange", "orange"] == Ok 33

# Ignore additional colors
expect value ["green", "brown", "orange"] == Ok 51

# Black and brown, one-digit
expect value ["black", "brown"] == Ok 1

