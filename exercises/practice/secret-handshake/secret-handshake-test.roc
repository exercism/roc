# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/secret-handshake/canonical-data.json
# File last updated on 2024-08-30
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import SecretHandshake exposing [commands]

# wink for 1
expect
    result = commands 1
    result == ["wink"]

# double blink for 10
expect
    result = commands 2
    result == ["double blink"]

# close your eyes for 100
expect
    result = commands 4
    result == ["close your eyes"]

# jump for 1000
expect
    result = commands 8
    result == ["jump"]

# combine two actions
expect
    result = commands 3
    result == ["wink", "double blink"]

# reverse two actions
expect
    result = commands 19
    result == ["double blink", "wink"]

# reversing one action gives the same action
expect
    result = commands 24
    result == ["jump"]

# reversing no actions still gives no actions
expect
    result = commands 16
    result == []

# all possible actions
expect
    result = commands 15
    result == ["wink", "double blink", "close your eyes", "jump"]

# reverse all possible actions
expect
    result = commands 31
    result == ["jump", "close your eyes", "double blink", "wink"]

# do nothing for zero
expect
    result = commands 0
    result == []

