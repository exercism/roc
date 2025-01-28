# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/isbn-verifier/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import IsbnVerifier exposing [is_valid]

# valid isbn
expect
    result = is_valid("3-598-21508-8")
    result == Bool.true

# invalid isbn check digit
expect
    result = is_valid("3-598-21508-9")
    result == Bool.false

# valid isbn with a check digit of 10
expect
    result = is_valid("3-598-21507-X")
    result == Bool.true

# check digit is a character other than X
expect
    result = is_valid("3-598-21507-A")
    result == Bool.false

# invalid check digit in isbn is not treated as zero
expect
    result = is_valid("4-598-21507-B")
    result == Bool.false

# invalid character in isbn is not treated as zero
expect
    result = is_valid("3-598-P1581-X")
    result == Bool.false

# X is only valid as a check digit
expect
    result = is_valid("3-598-2X507-9")
    result == Bool.false

# valid isbn without separating dashes
expect
    result = is_valid("3598215088")
    result == Bool.true

# isbn without separating dashes and X as check digit
expect
    result = is_valid("359821507X")
    result == Bool.true

# isbn without check digit and dashes
expect
    result = is_valid("359821507")
    result == Bool.false

# too long isbn and no dashes
expect
    result = is_valid("3598215078X")
    result == Bool.false

# too short isbn
expect
    result = is_valid("00")
    result == Bool.false

# isbn without check digit
expect
    result = is_valid("3-598-21507")
    result == Bool.false

# check digit of X should not be used for 0
expect
    result = is_valid("3-598-21515-X")
    result == Bool.false

# empty isbn
expect
    result = is_valid("")
    result == Bool.false

# input is 9 characters
expect
    result = is_valid("134456729")
    result == Bool.false

# invalid characters are not ignored after checking length
expect
    result = is_valid("3132P34035")
    result == Bool.false

# invalid characters are not ignored before checking length
expect
    result = is_valid("3598P215088")
    result == Bool.false

# input is too long but contains a valid isbn
expect
    result = is_valid("98245726788")
    result == Bool.false

