# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pangram/canonical-data.json
# File last updated on 2024-08-26
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br"
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import Pangram exposing [isPangram]

# empty sentence
expect isPangram "" == Bool.false

# perfect lower case
expect isPangram "abcdefghijklmnopqrstuvwxyz" == Bool.true

# only lower case
expect isPangram "the quick brown fox jumps over the lazy dog" == Bool.true

# missing the letter 'x'
expect isPangram "a quick movement of the enemy will jeopardize five gunboats" == Bool.false

# missing the letter 'h'
expect isPangram "five boxing wizards jump quickly at it" == Bool.false

# with underscores
expect isPangram "the_quick_brown_fox_jumps_over_the_lazy_dog" == Bool.true

# with numbers
expect isPangram "the 1 quick brown fox jumps over the 2 lazy dogs" == Bool.true

# missing letters replaced by numbers
expect isPangram "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog" == Bool.false

# mixed case and punctuation
expect isPangram "\"Five quacking Zephyrs jolt my wax bed.\"" == Bool.true

# a-m and A-M are 26 different characters but not a pangram
expect isPangram "abcdefghijklm ABCDEFGHIJKLM" == Bool.false


