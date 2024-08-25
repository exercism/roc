# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/armstrong-numbers/canonical-data.json
# File last updated on 2024-08-25
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.14.0/dC5ceT962N_4jmoyoffVdphJ_4GlW3YMhAPyGPr-nU0.tar.br",
}

import pf.Task exposing [Task]

main =
    Task.ok {}

import ArmstrongNumbers exposing [isArmstrongNumber]

# Zero is an Armstrong number
expect isArmstrongNumber 0 == Bool.true

# Single-digit numbers are Armstrong numbers
expect isArmstrongNumber 5 == Bool.true

# There are no two-digit Armstrong numbers
expect isArmstrongNumber 10 == Bool.false

# Three-digit number that is an Armstrong number
expect isArmstrongNumber 153 == Bool.true

# Three-digit number that is not an Armstrong number
expect isArmstrongNumber 100 == Bool.false

# Four-digit number that is an Armstrong number
expect isArmstrongNumber 9474 == Bool.true

# Four-digit number that is not an Armstrong number
expect isArmstrongNumber 9475 == Bool.false

# Seven-digit number that is an Armstrong number
expect isArmstrongNumber 9926315 == Bool.true

# Seven-digit number that is not an Armstrong number
expect isArmstrongNumber 9926314 == Bool.false

