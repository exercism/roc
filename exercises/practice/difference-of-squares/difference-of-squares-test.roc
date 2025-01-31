# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/difference-of-squares/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import DifferenceOfSquares exposing [square_of_sum, sum_of_squares, difference_of_squares]

##
## Square the sum of the numbers up to the given number
##

# square of sum 1
expect
    result = square_of_sum(1)
    result == 1

# square of sum 5
expect
    result = square_of_sum(5)
    result == 225

# square of sum 100
expect
    result = square_of_sum(100)
    result == 25502500

##
## Sum the squares of the numbers up to the given number
##

# sum of squares 1
expect
    result = sum_of_squares(1)
    result == 1

# sum of squares 5
expect
    result = sum_of_squares(5)
    result == 55

# sum of squares 100
expect
    result = sum_of_squares(100)
    result == 338350

##
## Subtract sum of squares from square of sums
##

# difference of squares 1
expect
    result = difference_of_squares(1)
    result == 0

# difference of squares 5
expect
    result = difference_of_squares(5)
    result == 170

# difference of squares 100
expect
    result = difference_of_squares(100)
    result == 25164150

