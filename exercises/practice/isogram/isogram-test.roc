# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/isogram/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Isogram exposing [isIsogram]

# empty string
expect
    result = isIsogram ""
    result == Bool.true

# isogram with only lower case characters
expect
    result = isIsogram "isogram"
    result == Bool.true

# word with one duplicated character
expect
    result = isIsogram "eleven"
    result == Bool.false

# word with one duplicated character from the end of the alphabet
expect
    result = isIsogram "zzyzx"
    result == Bool.false

# longest reported english isogram
expect
    result = isIsogram "subdermatoglyphic"
    result == Bool.true

# word with duplicated character in mixed case
expect
    result = isIsogram "Alphabet"
    result == Bool.false

# word with duplicated character in mixed case, lowercase first
expect
    result = isIsogram "alphAbet"
    result == Bool.false

# hypothetical isogrammic word with hyphen
expect
    result = isIsogram "thumbscrew-japingly"
    result == Bool.true

# hypothetical word with duplicated character following hyphen
expect
    result = isIsogram "thumbscrew-jappingly"
    result == Bool.false

# isogram with duplicated hyphen
expect
    result = isIsogram "six-year-old"
    result == Bool.true

# made-up name that is an isogram
expect
    result = isIsogram "Emily Jung Schwartzkopf"
    result == Bool.true

# duplicated character in the middle
expect
    result = isIsogram "accentor"
    result == Bool.false

# same first and last characters
expect
    result = isIsogram "angola"
    result == Bool.false

# word with duplicated character and with two hyphens
expect
    result = isIsogram "up-to-date"
    result == Bool.false

