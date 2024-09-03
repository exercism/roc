# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/armstrong-numbers/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import ArmstrongNumbers exposing [isArmstrongNumber]

# Zero is an Armstrong number
expect
    result = isArmstrongNumber 0
    result == Bool.true

# Single-digit numbers are Armstrong numbers
expect
    result = isArmstrongNumber 5
    result == Bool.true

# There are no two-digit Armstrong numbers
expect
    result = isArmstrongNumber 10
    result == Bool.false

# Three-digit number that is an Armstrong number
expect
    result = isArmstrongNumber 153
    result == Bool.true

# Three-digit number that is not an Armstrong number
expect
    result = isArmstrongNumber 100
    result == Bool.false

# Four-digit number that is an Armstrong number
expect
    result = isArmstrongNumber 9474
    result == Bool.true

# Four-digit number that is not an Armstrong number
expect
    result = isArmstrongNumber 9475
    result == Bool.false

# Seven-digit number that is an Armstrong number
expect
    result = isArmstrongNumber 9926315
    result == Bool.true

# Seven-digit number that is not an Armstrong number
expect
    result = isArmstrongNumber 9926314
    result == Bool.false

