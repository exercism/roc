# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/two-fer/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import TwoFer exposing [twoFer]

# no name given
expect
    result = twoFer Anonymous
    result == "One for you, one for me."

# a name given
expect
    result = twoFer (Name "Alice")
    result == "One for Alice, one for me."

# another name given
expect
    result = twoFer (Name "Bob")
    result == "One for Bob, one for me."

