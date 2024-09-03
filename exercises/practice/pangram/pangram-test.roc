# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pangram/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}
main =
    Task.ok {}

import Pangram exposing [isPangram]

# empty sentence
expect
    result = isPangram ""
    result == Bool.false

# perfect lower case
expect
    result = isPangram "abcdefghijklmnopqrstuvwxyz"
    result == Bool.true

# only lower case
expect
    result = isPangram "the quick brown fox jumps over the lazy dog"
    result == Bool.true

# missing the letter 'x'
expect
    result = isPangram "a quick movement of the enemy will jeopardize five gunboats"
    result == Bool.false

# missing the letter 'h'
expect
    result = isPangram "five boxing wizards jump quickly at it"
    result == Bool.false

# with underscores
expect
    result = isPangram "the_quick_brown_fox_jumps_over_the_lazy_dog"
    result == Bool.true

# with numbers
expect
    result = isPangram "the 1 quick brown fox jumps over the 2 lazy dogs"
    result == Bool.true

# missing letters replaced by numbers
expect
    result = isPangram "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"
    result == Bool.false

# mixed case and punctuation
expect
    result = isPangram "\"Five quacking Zephyrs jolt my wax bed.\""
    result == Bool.true

# a-m and A-M are 26 different characters but not a pangram
expect
    result = isPangram "abcdefghijklm ABCDEFGHIJKLM"
    result == Bool.false

