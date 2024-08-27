# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/reverse-string/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
    unicode: "https://github.com/roc-lang/unicode/releases/download/0.1.2/vH5iqn04ShmqP-pNemgF773f86COePSqMWHzVGrAKNo.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import ReverseString exposing [reverse]

# an empty string
expect
    result = reverse ""
    result == ""

# a word
expect
    result = reverse "robot"
    result == "tobor"

# a capitalized word
expect
    result = reverse "Ramen"
    result == "nemaR"

# a sentence with punctuation
expect
    result = reverse "I'm hungry!"
    result == "!yrgnuh m'I"

# a palindrome
expect
    result = reverse "racecar"
    result == "racecar"

# an even-sized word
expect
    result = reverse "drawer"
    result == "reward"

# wide characters
expect
    result = reverse "子猫"
    result == "猫子"

# grapheme cluster with pre-combined form
expect
    result = reverse "Würstchenstand"
    result == "dnatsnehctsrüW"

# grapheme clusters
expect
    result = reverse "ผู้เขียนโปรแกรม"
    result == "มรกแรปโนยขีเผู้"

