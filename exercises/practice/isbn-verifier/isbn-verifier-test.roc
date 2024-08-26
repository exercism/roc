# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/isbn-verifier/canonical-data.json
# File last updated on 2024-08-26
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import IsbnVerifier exposing [isValid]

# valid isbn
expect isValid "3-598-21508-8" == Bool.true

# invalid isbn check digit
expect isValid "3-598-21508-9" == Bool.false

# valid isbn with a check digit of 10
expect isValid "3-598-21507-X" == Bool.true

# check digit is a character other than X
expect isValid "3-598-21507-A" == Bool.false

# invalid check digit in isbn is not treated as zero
expect isValid "4-598-21507-B" == Bool.false

# invalid character in isbn is not treated as zero
expect isValid "3-598-P1581-X" == Bool.false

# X is only valid as a check digit
expect isValid "3-598-2X507-9" == Bool.false

# valid isbn without separating dashes
expect isValid "3598215088" == Bool.true

# isbn without separating dashes and X as check digit
expect isValid "359821507X" == Bool.true

# isbn without check digit and dashes
expect isValid "359821507" == Bool.false

# too long isbn and no dashes
expect isValid "3598215078X" == Bool.false

# too short isbn
expect isValid "00" == Bool.false

# isbn without check digit
expect isValid "3-598-21507" == Bool.false

# check digit of X should not be used for 0
expect isValid "3-598-21515-X" == Bool.false

# empty isbn
expect isValid "" == Bool.false

# input is 9 characters
expect isValid "134456729" == Bool.false

# invalid characters are not ignored after checking length
expect isValid "3132P34035" == Bool.false

# invalid characters are not ignored before checking length
expect isValid "3598P215088" == Bool.false

# input is too long but contains a valid isbn
expect isValid "98245726788" == Bool.false

