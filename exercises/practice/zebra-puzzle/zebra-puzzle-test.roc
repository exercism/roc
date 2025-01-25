# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/zebra-puzzle/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/bi5zubJ-_Hva9vxxPq4kNx4WHX6oFs8OP6Ad0tCYlrY.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import ZebraPuzzle exposing [owns_zebra, drinks_water]

# resident who drinks water
expect
    result = drinks_water
    result == Ok(Norwegian)

# resident who owns zebra
expect
    result = owns_zebra
    result == Ok(Japanese)

