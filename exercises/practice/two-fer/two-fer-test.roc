# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/two-fer/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/bi5zubJ-_Hva9vxxPq4kNx4WHX6oFs8OP6Ad0tCYlrY.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import TwoFer exposing [two_fer]

# no name given
expect
    result = two_fer(Anonymous)
    result == "One for you, one for me."

# a name given
expect
    result = two_fer(Name("Alice"))
    result == "One for Alice, one for me."

# another name given
expect
    result = two_fer(Name("Bob"))
    result == "One for Bob, one for me."

