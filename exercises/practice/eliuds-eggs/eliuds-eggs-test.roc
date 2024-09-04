# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/eliuds-eggs/canonical-data.json
# File last updated on 2024-09-04
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import EliudsEggs exposing [eggCount]

# 0 eggs
expect
    result = eggCount 0
    result == 0

# 1 egg
expect
    result = eggCount 16
    result == 1

# 4 eggs
expect
    result = eggCount 89
    result == 4

# 13 eggs
expect
    result = eggCount 2000000000
    result == 13

