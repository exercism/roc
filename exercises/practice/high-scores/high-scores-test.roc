# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/high-scores/canonical-data.json
# File last updated on 2024-10-06
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.17.0/lZFLstMUCUvd5bjnnpYromZJXkQUrdhbva4xdBInicE.tar.br",
}

main =
    Task.ok {}

import HighScores exposing [latest, personalBest, personalTopThree]

## Latest score
expect
    result = latest [100, 0, 90, 30]
    result == Ok 30

## Personal best
expect
    result = personalBest [40, 100, 70]
    result == Ok 100

## Top 3 scores
# Personal top three from a list of scores
expect
    result = personalTopThree [10, 30, 90, 30, 100, 20, 10, 0, 30, 40, 40, 70, 70]
    result == [100, 90, 70]

# Personal top highest to lowest
expect
    result = personalTopThree [20, 10, 30]
    result == [30, 20, 10]

# Personal top when there is a tie
expect
    result = personalTopThree [40, 20, 40, 30]
    result == [40, 40, 30]

# Personal top when there are less than 3
expect
    result = personalTopThree [30, 70]
    result == [70, 30]

# Personal top when there is only one
expect
    result = personalTopThree [40]
    result == [40]

