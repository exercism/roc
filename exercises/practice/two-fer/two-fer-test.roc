# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/two-fer/canonical-data.json
# File last updated on 2024-08-26
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import TwoFer exposing [twoFer]

# no name given
expect twoFer Anonymous == "One for you, one for me."

# a name given
expect twoFer (Name "Alice") == "One for Alice, one for me."

# another name given
expect twoFer (Name "Bob") == "One for Bob, one for me."
