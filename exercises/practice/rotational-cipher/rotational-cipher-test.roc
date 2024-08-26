# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rotational-cipher/canonical-data.json
# File last updated on 2024-08-26
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import RotationalCipher exposing [rotate]

# rotate a by 0, same output as input
expect rotate "a" 0 == "a"

# rotate a by 1
expect rotate "a" 1 == "b"

# rotate a by 26, same output as input
expect rotate "a" 26 == "a"

# rotate m by 13
expect rotate "m" 13 == "z"

# rotate n by 13 with wrap around alphabet
expect rotate "n" 13 == "a"

# rotate capital letters
expect rotate "OMG" 5 == "TRL"

# rotate spaces
expect rotate "O M G" 5 == "T R L"

# rotate numbers
expect rotate "Testing 1 2 3 testing" 4 == "Xiwxmrk 1 2 3 xiwxmrk"

# rotate punctuation
expect rotate "Let's eat, Grandma!" 21 == "Gzo'n zvo, Bmviyhv!"

# rotate all letters
expect rotate "The quick brown fox jumps over the lazy dog." 13 == "Gur dhvpx oebja sbk whzcf bire gur ynml qbt."

