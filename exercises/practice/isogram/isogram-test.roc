# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/isogram/canonical-data.json
# File last updated on 2024-08-26
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import Isogram exposing [isIsogram]

# empty string
expect isIsogram "" == Bool.true

# isogram with only lower case characters
expect isIsogram "isogram" == Bool.true

# word with one duplicated character
expect isIsogram "eleven" == Bool.false

# word with one duplicated character from the end of the alphabet
expect isIsogram "zzyzx" == Bool.false

# longest reported english isogram
expect isIsogram "subdermatoglyphic" == Bool.true

# word with duplicated character in mixed case
expect isIsogram "Alphabet" == Bool.false

# word with duplicated character in mixed case, lowercase first
expect isIsogram "alphAbet" == Bool.false

# hypothetical isogrammic word with hyphen
expect isIsogram "thumbscrew-japingly" == Bool.true

# hypothetical word with duplicated character following hyphen
expect isIsogram "thumbscrew-jappingly" == Bool.false

# isogram with duplicated hyphen
expect isIsogram "six-year-old" == Bool.true

# made-up name that is an isogram
expect isIsogram "Emily Jung Schwartzkopf" == Bool.true

# duplicated character in the middle
expect isIsogram "accentor" == Bool.false

# same first and last characters
expect isIsogram "angola" == Bool.false

# word with duplicated character and with two hyphens
expect isIsogram "up-to-date" == Bool.false

