# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/scrabble-score/canonical-data.json
# File last updated on 2024-09-10
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import ScrabbleScore exposing [score]

# lowercase letter
expect
    result = score "a"
    result == 1

# uppercase letter
expect
    result = score "A"
    result == 1

# valuable letter
expect
    result = score "f"
    result == 4

# short word
expect
    result = score "at"
    result == 2

# short, valuable word
expect
    result = score "zoo"
    result == 12

# medium word
expect
    result = score "street"
    result == 6

# medium, valuable word
expect
    result = score "quirky"
    result == 22

# long, mixed-case word
expect
    result = score "OxyphenButazone"
    result == 41

# english-like word
expect
    result = score "pinata"
    result == 8

# empty input
expect
    result = score ""
    result == 0

# entire alphabet available
expect
    result = score "abcdefghijklmnopqrstuvwxyz"
    result == 87

