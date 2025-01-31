# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/reverse-string/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
    unicode: "https://github.com/roc-lang/unicode/releases/download/0.3.0/9KKFsA4CdOz0JIOL7iBSI_2jGIXQ6TsFBXgd086idpY.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import ReverseString exposing [reverse]

# an empty string
expect
    result = reverse("")
    result == ""

# a word
expect
    result = reverse("robot")
    result == "tobor"

# a capitalized word
expect
    result = reverse("Ramen")
    result == "nemaR"

# a sentence with punctuation
expect
    result = reverse("I'm hungry!")
    result == "!yrgnuh m'I"

# a palindrome
expect
    result = reverse("racecar")
    result == "racecar"

# an even-sized word
expect
    result = reverse("drawer")
    result == "reward"

# wide characters
expect
    result = reverse("子猫")
    result == "猫子"

# grapheme cluster with pre-combined form
expect
    result = reverse("Würstchenstand")
    result == "dnatsnehctsrüW"

# grapheme clusters
expect
    result = reverse("ผู้เขียนโปรแกรม")
    result == "มรกแรปโนยขีเผู้"

