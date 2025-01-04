# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/micro-blog/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
    unicode: "https://github.com/roc-lang/unicode/releases/download/0.2.0/odvSckHK9LxWLbsrPmo2s6aQ3bn7C3PALyv0ZI1gAu0.tar.br",
}

import pf.Stdout

main! = \_args ->
    Stdout.line! ""

import MicroBlog exposing [truncate]

# English language short
expect
    result = truncate "Hi"
    result == Ok "Hi"

# English language long
expect
    result = truncate "Hello there"
    result == Ok "Hello"

# German language short (broth)
expect
    result = truncate "brühe"
    result == Ok "brühe"

# German language long (bear carpet → beards)
expect
    result = truncate "Bärteppich"
    result == Ok "Bärte"

# Bulgarian language short (good)
expect
    result = truncate "Добър"
    result == Ok "Добър"

# Greek language short (health)
expect
    result = truncate "υγειά"
    result == Ok "υγειά"

# Maths short
expect
    result = truncate "a=πr²"
    result == Ok "a=πr²"

# Maths long
expect
    result = truncate "∅⊊ℕ⊊ℤ⊊ℚ⊊ℝ⊊ℂ"
    result == Ok "∅⊊ℕ⊊ℤ"

# English and emoji short
expect
    result = truncate "Fly 🛫"
    result == Ok "Fly 🛫"

# Emoji short
expect
    result = truncate "💇"
    result == Ok "💇"

# Emoji long
expect
    result = truncate "❄🌡🤧🤒🏥🕰😀"
    result == Ok "❄🌡🤧🤒🏥"

# Royal Flush?
expect
    result = truncate "🃎🂸🃅🃋🃍🃁🃊"
    result == Ok "🃎🂸🃅🃋🃍"

