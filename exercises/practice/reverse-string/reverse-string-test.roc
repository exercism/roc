# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/reverse-string/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
    unicode: "https://github.com/roc-lang/unicode/releases/download/0.2.0/odvSckHK9LxWLbsrPmo2s6aQ3bn7C3PALyv0ZI1gAu0.tar.br",
}

main! = \_args ->
    Ok {}

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

