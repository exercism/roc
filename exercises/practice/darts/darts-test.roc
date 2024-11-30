# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/darts/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.17.0/lZFLstMUCUvd5bjnnpYromZJXkQUrdhbva4xdBInicE.tar.br",
}

main =
    Task.ok {}

import Darts exposing [score]

# Missed target
expect
    result = score -9.0f64 9.0f64
    result == 0

# On the outer circle
expect
    result = score 0.0f64 10.0f64
    result == 1

# On the middle circle
expect
    result = score -5.0f64 0.0f64
    result == 5

# On the inner circle
expect
    result = score 0.0f64 -1.0f64
    result == 10

# Exactly on center
expect
    result = score 0.0f64 0.0f64
    result == 10

# Near the center
expect
    result = score -0.1f64 -0.1f64
    result == 10

# Just within the inner circle
expect
    result = score 0.7f64 0.7f64
    result == 10

# Just outside the inner circle
expect
    result = score 0.8f64 -0.8f64
    result == 5

# Just within the middle circle
expect
    result = score -3.5f64 3.5f64
    result == 5

# Just outside the middle circle
expect
    result = score -3.6f64 -3.6f64
    result == 1

# Just within the outer circle
expect
    result = score -7.0f64 7.0f64
    result == 1

# Just outside the outer circle
expect
    result = score 7.1f64 -7.1f64
    result == 0

# Asymmetric position between the inner and middle circles
expect
    result = score 0.5f64 -4.0f64
    result == 5

