# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/difference-of-squares/canonical-data.json
# File last updated on 2024-08-27
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import DifferenceOfSquares exposing [squareOfSum, sumOfSquares, differenceOfSquares]

##
## Square the sum of the numbers up to the given number
##

# square of sum 1
expect
    result = squareOfSum 1
    result == 1

# square of sum 5
expect
    result = squareOfSum 5
    result == 225

# square of sum 100
expect
    result = squareOfSum 100
    result == 25502500

##
## Sum the squares of the numbers up to the given number
##

# sum of squares 1
expect
    result = sumOfSquares 1
    result == 1

# sum of squares 5
expect
    result = sumOfSquares 5
    result == 55

# sum of squares 100
expect
    result = sumOfSquares 100
    result == 338350

##
## Subtract sum of squares from square of sums
##

# difference of squares 1
expect
    result = differenceOfSquares 1
    result == 0

# difference of squares 5
expect
    result = differenceOfSquares 5
    result == 170

# difference of squares 100
expect
    result = differenceOfSquares 100
    result == 25164150

