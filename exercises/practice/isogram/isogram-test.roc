# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/isogram/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Isogram exposing [is_isogram]

# empty string
expect
    result = is_isogram("")
    result == Bool.true

# isogram with only lower case characters
expect
    result = is_isogram("isogram")
    result == Bool.true

# word with one duplicated character
expect
    result = is_isogram("eleven")
    result == Bool.false

# word with one duplicated character from the end of the alphabet
expect
    result = is_isogram("zzyzx")
    result == Bool.false

# longest reported english isogram
expect
    result = is_isogram("subdermatoglyphic")
    result == Bool.true

# word with duplicated character in mixed case
expect
    result = is_isogram("Alphabet")
    result == Bool.false

# word with duplicated character in mixed case, lowercase first
expect
    result = is_isogram("alphAbet")
    result == Bool.false

# hypothetical isogrammic word with hyphen
expect
    result = is_isogram("thumbscrew-japingly")
    result == Bool.true

# hypothetical word with duplicated character following hyphen
expect
    result = is_isogram("thumbscrew-jappingly")
    result == Bool.false

# isogram with duplicated hyphen
expect
    result = is_isogram("six-year-old")
    result == Bool.true

# made-up name that is an isogram
expect
    result = is_isogram("Emily Jung Schwartzkopf")
    result == Bool.true

# duplicated character in the middle
expect
    result = is_isogram("accentor")
    result == Bool.false

# same first and last characters
expect
    result = is_isogram("angola")
    result == Bool.false

# word with duplicated character and with two hyphens
expect
    result = is_isogram("up-to-date")
    result == Bool.false

