# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/perfect-numbers/canonical-data.json
# File last updated on 2024-08-26
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import PerfectNumbers exposing [classify]

##
## Perfect numbers
##

# Smallest perfect number is classified correctly
expect classify 6 == Ok Perfect

# Medium perfect number is classified correctly
expect classify 28 == Ok Perfect

# Large perfect number is classified correctly
expect classify 33550336 == Ok Perfect

##
## Abundant numbers
##

# Smallest abundant number is classified correctly
expect classify 12 == Ok Abundant

# Medium abundant number is classified correctly
expect classify 30 == Ok Abundant

# Large abundant number is classified correctly
expect classify 33550335 == Ok Abundant

##
## Deficient numbers
##

# Smallest prime deficient number is classified correctly
expect classify 2 == Ok Deficient

# Smallest non-prime deficient number is classified correctly
expect classify 4 == Ok Deficient

# Medium deficient number is classified correctly
expect classify 32 == Ok Deficient

# Large deficient number is classified correctly
expect classify 33550337 == Ok Deficient

# Edge case (no factors other than itself) is classified correctly
expect classify 1 == Ok Deficient

##
## Invalid inputs
##

# Zero is rejected (as it is not a positive integer)
expect classify 0 == Err "Classification is only possible for positive integers."

# Negative integer is rejected (as it is not a positive integer)
expect classify -1 == Err "Classification is only possible for positive integers."

