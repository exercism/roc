# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/darts/canonical-data.json
# File last updated on 2024-08-23
app [main] { pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.12.0/Lb8EgiejTUzbggO2HVVuPJFkwvvsfW6LojkLR20kTVE.tar.br" }

import pf.Task exposing [Task]

main =
    Task.ok {}

import Darts exposing [score]

# Missed target
expect score -9f64 9f64 == 0

# On the outer circle
expect score 0f64 10f64 == 1

# On the middle circle
expect score -5f64 0f64 == 5

# On the inner circle
expect score 0f64 -1f64 == 10

# Exactly on center
expect score 0f64 0f64 == 10

# Near the center
expect score -0.1f64 -0.1f64 == 10

# Just within the inner circle
expect score 0.7f64 0.7f64 == 10

# Just outside the inner circle
expect score 0.8f64 -0.8f64 == 5

# Just within the middle circle
expect score -3.5f64 3.5f64 == 5

# Just outside the middle circle
expect score -3.6f64 -3.6f64 == 1

# Just within the outer circle
expect score -7.0f64 7.0f64 == 1

# Just outside the outer circle
expect score 7.1f64 -7.1f64 == 0

# Asymmetric position between the inner and middle circles
expect score 0.5f64 -4f64 == 5

