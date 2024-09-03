# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/collatz-conjecture/canonical-data.json
# File last updated on 2024-09-03
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import CollatzConjecture exposing [steps]

# zero steps for one
expect
    result = steps 1
    result == Ok 0

# divide if even
expect
    result = steps 16
    result == Ok 4

# even and odd steps
expect
    result = steps 12
    result == Ok 9

# large number of even and odd steps
expect
    result = steps 1000000
    result == Ok 152

# zero is an error
expect
    result = steps 0
    Result.isErr result

