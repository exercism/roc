# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/eliuds-eggs/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/bi5zubJ-_Hva9vxxPq4kNx4WHX6oFs8OP6Ad0tCYlrY.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import EliudsEggs exposing [egg_count]

# 0 eggs
expect
    result = egg_count(0)
    result == 0

# 1 egg
expect
    result = egg_count(16)
    result == 1

# 4 eggs
expect
    result = egg_count(89)
    result == 4

# 13 eggs
expect
    result = egg_count(2000000000)
    result == 13

