# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/high-scores/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import HighScores exposing [latest, personal_best, personal_top_three]

## Latest score
expect
    result = latest([100, 0, 90, 30])
    result == Ok(30)

## Personal best
expect
    result = personal_best([40, 100, 70])
    result == Ok(100)

## Top 3 scores
# Personal top three from a list of scores
expect
    result = personal_top_three([10, 30, 90, 30, 100, 20, 10, 0, 30, 40, 40, 70, 70])
    result == [100, 90, 70]

# Personal top highest to lowest
expect
    result = personal_top_three([20, 10, 30])
    result == [30, 20, 10]

# Personal top when there is a tie
expect
    result = personal_top_three([40, 20, 40, 30])
    result == [40, 40, 30]

# Personal top when there are less than 3
expect
    result = personal_top_three([30, 70])
    result == [70, 30]

# Personal top when there is only one
expect
    result = personal_top_three([40])
    result == [40]

