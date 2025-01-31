# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/acronym/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Acronym exposing [abbreviate]

# basic
expect
    result = abbreviate("Portable Network Graphics")
    result == "PNG"

# lowercase words
expect
    result = abbreviate("Ruby on Rails")
    result == "ROR"

# punctuation
expect
    result = abbreviate("First In, First Out")
    result == "FIFO"

# all caps word
expect
    result = abbreviate("GNU Image Manipulation Program")
    result == "GIMP"

# punctuation without whitespace
expect
    result = abbreviate("Complementary metal-oxide semiconductor")
    result == "CMOS"

# very long abbreviation
expect
    result = abbreviate("Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me")
    result == "ROTFLSHTMDCOALM"

# consecutive delimiters
expect
    result = abbreviate("Something - I made up from thin air")
    result == "SIMUFTA"

# apostrophes
expect
    result = abbreviate("Halley's Comet")
    result == "HC"

# underscore emphasis
expect
    result = abbreviate("The Road _Not_ Taken")
    result == "TRNT"

