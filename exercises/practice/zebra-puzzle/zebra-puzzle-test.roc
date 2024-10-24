# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/zebra-puzzle/canonical-data.json
# File last updated on 2024-10-22
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import ZebraPuzzle exposing [ownsZebra, drinksWater]

# resident who drinks water
expect
    result = drinksWater
    result == Ok Norwegian

# resident who owns zebra
expect
    result = ownsZebra
    result == Ok Japanese

