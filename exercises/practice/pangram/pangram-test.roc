# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pangram/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Pangram exposing [is_pangram]

# empty sentence
expect
    result = is_pangram("")
    result == Bool.false

# perfect lower case
expect
    result = is_pangram("abcdefghijklmnopqrstuvwxyz")
    result == Bool.true

# only lower case
expect
    result = is_pangram("the quick brown fox jumps over the lazy dog")
    result == Bool.true

# missing the letter 'x'
expect
    result = is_pangram("a quick movement of the enemy will jeopardize five gunboats")
    result == Bool.false

# missing the letter 'h'
expect
    result = is_pangram("five boxing wizards jump quickly at it")
    result == Bool.false

# with underscores
expect
    result = is_pangram("the_quick_brown_fox_jumps_over_the_lazy_dog")
    result == Bool.true

# with numbers
expect
    result = is_pangram("the 1 quick brown fox jumps over the 2 lazy dogs")
    result == Bool.true

# missing letters replaced by numbers
expect
    result = is_pangram("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog")
    result == Bool.false

# mixed case and punctuation
expect
    result = is_pangram("\"Five quacking Zephyrs jolt my wax bed.\"")
    result == Bool.true

# a-m and A-M are 26 different characters but not a pangram
expect
    result = is_pangram("abcdefghijklm ABCDEFGHIJKLM")
    result == Bool.false

