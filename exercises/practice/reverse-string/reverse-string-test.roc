# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/reverse-string/canonical-data.json
# File last updated on 2024-08-25
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
    unicode: "https://github.com/roc-lang/unicode/releases/download/0.1.1/-FQDoegpSfMS-a7B0noOnZQs3-A2aq9RSOR5VVLMePg.tar.br"
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import ReverseString exposing [reverse]

# an empty string
expect reverse "" == ""

# a word
expect reverse "robot" == "tobor"

# a capitalized word
expect reverse "Ramen" == "nemaR"

# a sentence with punctuation
expect reverse "I'm hungry!" == "!yrgnuh m'I"

# a palindrome
expect reverse "racecar" == "racecar"

# an even-sized word
expect reverse "drawer" == "reward"

# wide characters
expect reverse "子猫" == "猫子"

# grapheme cluster with pre-combined form
expect reverse "Würstchenstand" == "dnatsnehctsrüW"

# grapheme clusters
expect reverse "ผู้เขียนโปรแกรม" == "มรกแรปโนยขีเผู้"


