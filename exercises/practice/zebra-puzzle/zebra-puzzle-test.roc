# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/zebra-puzzle/canonical-data.json
# File last updated on 2024-10-22
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.18.0/0APbwVN1_p1mJ96tXjaoiUCr8NBGamr8G8Ac_DrXR-o.tar.br",
}

main! = \_args ->
    Ok {}

import ZebraPuzzle exposing [owns_zebra, drinks_water]

# resident who drinks water
expect
    result = drinks_water
    result == Ok Norwegian

# resident who owns zebra
expect
    result = owns_zebra
    result == Ok Japanese

