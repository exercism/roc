# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rotational-cipher/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import RotationalCipher exposing [rotate]

# rotate a by 0, same output as input
expect
    result = rotate("a", 0)
    result == "a"

# rotate a by 1
expect
    result = rotate("a", 1)
    result == "b"

# rotate a by 26, same output as input
expect
    result = rotate("a", 26)
    result == "a"

# rotate m by 13
expect
    result = rotate("m", 13)
    result == "z"

# rotate n by 13 with wrap around alphabet
expect
    result = rotate("n", 13)
    result == "a"

# rotate capital letters
expect
    result = rotate("OMG", 5)
    result == "TRL"

# rotate spaces
expect
    result = rotate("O M G", 5)
    result == "T R L"

# rotate numbers
expect
    result = rotate("Testing 1 2 3 testing", 4)
    result == "Xiwxmrk 1 2 3 xiwxmrk"

# rotate punctuation
expect
    result = rotate("Let's eat, Grandma!", 21)
    result == "Gzo'n zvo, Bmviyhv!"

# rotate all letters
expect
    result = rotate("The quick brown fox jumps over the lazy dog.", 13)
    result == "Gur dhvpx oebja sbk whzcf bire gur ynml qbt."

