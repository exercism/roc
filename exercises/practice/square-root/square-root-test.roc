# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/square-root/canonical-data.json
# File last updated on 2024-08-29
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import SquareRoot exposing [squareRoot]

# root of 1
expect
    result = squareRoot 1
    result == 1

# root of 4
expect
    result = squareRoot 4
    result == 2

# root of 25
expect
    result = squareRoot 25
    result == 5

# root of 81
expect
    result = squareRoot 81
    result == 9

# root of 196
expect
    result = squareRoot 196
    result == 14

# root of 65025
expect
    result = squareRoot 65025
    result == 255

