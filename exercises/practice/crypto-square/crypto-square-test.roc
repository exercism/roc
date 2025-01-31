# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/crypto-square/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import CryptoSquare exposing [ciphertext]

# empty plaintext results in an empty ciphertext
expect
    text = ""
    result = ciphertext(text)
    expected = Ok("")
    result == expected

# normalization results in empty plaintext
expect
    text = "... --- ..."
    result = ciphertext(text)
    expected = Ok("")
    result == expected

# Lowercase
expect
    text = "A"
    result = ciphertext(text)
    expected = Ok("a")
    result == expected

# Remove spaces
expect
    text = "  b "
    result = ciphertext(text)
    expected = Ok("b")
    result == expected

# Remove punctuation
expect
    text = "@1,%!"
    result = ciphertext(text)
    expected = Ok("1")
    result == expected

# 9 character plaintext results in 3 chunks of 3 characters
expect
    text = "This is fun!"
    result = ciphertext(text)
    expected = Ok("tsf hiu isn")
    result == expected

# 8 character plaintext results in 3 chunks, the last one with a trailing space
expect
    text = "Chill out."
    result = ciphertext(text)
    expected = Ok("clu hlt io ")
    result == expected

# 54 character plaintext results in 7 chunks, the last two with trailing spaces
expect
    text = "If man was meant to stay on the ground, god would have given us roots."
    result = ciphertext(text)
    expected = Ok("imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau ")
    result == expected

