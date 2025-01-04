# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pangram/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
}
main! = \_args ->
    Ok {}

import Pangram exposing [is_pangram]

# empty sentence
expect
    result = is_pangram ""
    result == Bool.false

# perfect lower case
expect
    result = is_pangram "abcdefghijklmnopqrstuvwxyz"
    result == Bool.true

# only lower case
expect
    result = is_pangram "the quick brown fox jumps over the lazy dog"
    result == Bool.true

# missing the letter 'x'
expect
    result = is_pangram "a quick movement of the enemy will jeopardize five gunboats"
    result == Bool.false

# missing the letter 'h'
expect
    result = is_pangram "five boxing wizards jump quickly at it"
    result == Bool.false

# with underscores
expect
    result = is_pangram "the_quick_brown_fox_jumps_over_the_lazy_dog"
    result == Bool.true

# with numbers
expect
    result = is_pangram "the 1 quick brown fox jumps over the 2 lazy dogs"
    result == Bool.true

# missing letters replaced by numbers
expect
    result = is_pangram "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"
    result == Bool.false

# mixed case and punctuation
expect
    result = is_pangram "\"Five quacking Zephyrs jolt my wax bed.\""
    result == Bool.true

# a-m and A-M are 26 different characters but not a pangram
expect
    result = is_pangram "abcdefghijklm ABCDEFGHIJKLM"
    result == Bool.false

