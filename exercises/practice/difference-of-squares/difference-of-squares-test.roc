# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/difference-of-squares/canonical-data.json
# File last updated on 2024-08-23
app [main] { pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.12.0/Lb8EgiejTUzbggO2HVVuPJFkwvvsfW6LojkLR20kTVE.tar.br" }

import pf.Task exposing [Task]

main =
    Task.ok {}

import DifferenceOfSquares exposing [squareOfSum, sumOfSquares, differenceOfSquares]

##
## Square the sum of the numbers up to the given number
##

# square of sum 1
expect squareOfSum 1 == 1

# square of sum 5
expect squareOfSum 5 == 225

# square of sum 100
expect squareOfSum 100 == 25502500

##
## Sum the squares of the numbers up to the given number
##

# sum of squares 1
expect sumOfSquares 1 == 1

# sum of squares 5
expect sumOfSquares 5 == 55

# sum of squares 100
expect sumOfSquares 100 == 338350

##
## Subtract sum of squares from square of sums
##

# difference of squares 1
expect differenceOfSquares 1 == 0

# difference of squares 5
expect differenceOfSquares 5 == 170

# difference of squares 100
expect differenceOfSquares 100 == 25164150

