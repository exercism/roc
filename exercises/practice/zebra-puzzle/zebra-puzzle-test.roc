# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/zebra-puzzle/canonical-data.json
# File last updated on 2025-09-15
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.20.0/X73hGh05nNTkDHU06FHC0YfFaQB1pimX7gncRcao5mU.tar.br",
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

