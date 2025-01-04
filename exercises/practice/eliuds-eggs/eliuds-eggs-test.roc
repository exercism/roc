# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/eliuds-eggs/canonical-data.json
# File last updated on 2024-09-04
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
}

main! = \_args ->
    Ok {}

import EliudsEggs exposing [egg_count]

# 0 eggs
expect
    result = egg_count 0
    result == 0

# 1 egg
expect
    result = egg_count 16
    result == 1

# 4 eggs
expect
    result = egg_count 89
    result == 4

# 13 eggs
expect
    result = egg_count 2000000000
    result == 13

