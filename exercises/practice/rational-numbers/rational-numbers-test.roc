# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rational-numbers/canonical-data.json
# File last updated on 2024-09-06
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import RationalNumbers exposing [add, sub, mul, div, abs, exp, expReal, reduce]

##
## Arithmetic
##

# Add two positive rational numbers
expect
    result = Rational 1 2 |> add (Rational 2 3)
    result == Rational 7 6

# Add a positive rational number and a negative rational number
expect
    result = Rational 1 2 |> add (Rational -2 3)
    result == Rational -1 6

# Add two negative rational numbers
expect
    result = Rational -1 2 |> add (Rational -2 3)
    result == Rational -7 6

# Add a rational number to its additive inverse
expect
    result = Rational 1 2 |> add (Rational -1 2)
    result == Rational 0 1

# Subtract two positive rational numbers
expect
    result = Rational 1 2 |> sub (Rational 2 3)
    result == Rational -1 6

# Subtract a positive rational number and a negative rational number
expect
    result = Rational 1 2 |> sub (Rational -2 3)
    result == Rational 7 6

# Subtract two negative rational numbers
expect
    result = Rational -1 2 |> sub (Rational -2 3)
    result == Rational 1 6

# Subtract a rational number from itself
expect
    result = Rational 1 2 |> sub (Rational 1 2)
    result == Rational 0 1

# Multiply two positive rational numbers
expect
    result = Rational 1 2 |> mul (Rational 2 3)
    result == Rational 1 3

# Multiply a negative rational number by a positive rational number
expect
    result = Rational -1 2 |> mul (Rational 2 3)
    result == Rational -1 3

# Multiply two negative rational numbers
expect
    result = Rational -1 2 |> mul (Rational -2 3)
    result == Rational 1 3

# Multiply a rational number by its reciprocal
expect
    result = Rational 1 2 |> mul (Rational 2 1)
    result == Rational 1 1

# Multiply a rational number by 1
expect
    result = Rational 1 2 |> mul (Rational 1 1)
    result == Rational 1 2

# Multiply a rational number by 0
expect
    result = Rational 1 2 |> mul (Rational 0 1)
    result == Rational 0 1

# Divide two positive rational numbers
expect
    result = Rational 1 2 |> div (Rational 2 3)
    result == Rational 3 4

# Divide a positive rational number by a negative rational number
expect
    result = Rational 1 2 |> div (Rational -2 3)
    result == Rational -3 4

# Divide two negative rational numbers
expect
    result = Rational -1 2 |> div (Rational -2 3)
    result == Rational 3 4

# Divide a rational number by 1
expect
    result = Rational 1 2 |> div (Rational 1 1)
    result == Rational 1 2

##
## Absolute value
##

# Absolute value of a positive rational number
expect
    result = Rational 1 2 |> abs
    result == Rational 1 2

# Absolute value of a positive rational number with negative numerator and denominator
expect
    result = Rational -1 -2 |> abs
    result == Rational 1 2

# Absolute value of a negative rational number
expect
    result = Rational -1 2 |> abs
    result == Rational 1 2

# Absolute value of a negative rational number with negative denominator
expect
    result = Rational 1 -2 |> abs
    result == Rational 1 2

# Absolute value of zero
expect
    result = Rational 0 1 |> abs
    result == Rational 0 1

# Absolute value of a rational number is reduced to lowest terms
expect
    result = Rational 2 4 |> abs
    result == Rational 1 2

##
## Exponentiation of a rational number
##

# Raise a positive rational number to a positive integer power
expect
    result = Rational 1 2 |> exp 3
    result == Rational 1 8

# Raise a negative rational number to a positive integer power
expect
    result = Rational -1 2 |> exp 3
    result == Rational -1 8

# Raise a positive rational number to a negative integer power
expect
    result = Rational 3 5 |> exp -2
    result == Rational 25 9

# Raise a negative rational number to an even negative integer power
expect
    result = Rational -3 5 |> exp -2
    result == Rational 25 9

# Raise a negative rational number to an odd negative integer power
expect
    result = Rational -3 5 |> exp -3
    result == Rational -125 27

# Raise zero to an integer power
expect
    result = Rational 0 1 |> exp 5
    result == Rational 0 1

# Raise one to an integer power
expect
    result = Rational 1 1 |> exp 4
    result == Rational 1 1

# Raise a positive rational number to the power of zero
expect
    result = Rational 1 2 |> exp 0
    result == Rational 1 1

# Raise a negative rational number to the power of zero
expect
    result = Rational -1 2 |> exp 0
    result == Rational 1 1

##
## Exponentiation of a real number to a rational number
##

# Raise a real number to a positive rational number
expect
    result = 8 |> expReal (Rational 4 3)
    result |> Num.isApproxEq 16.0f64 {}

# Raise a real number to a negative rational number
expect
    result = 9 |> expReal (Rational -1 2)
    result |> Num.isApproxEq 0.3333333333333333f64 {}

# Raise a real number to a zero rational number
expect
    result = 2 |> expReal (Rational 0 1)
    result |> Num.isApproxEq 1.0f64 {}

##
## Reduction to lowest terms
##

# Reduce a positive rational number to lowest terms
expect
    result = Rational 2 4 |> reduce
    result == Rational 1 2

# Reduce places the minus sign on the numerator
expect
    result = Rational 3 -4 |> reduce
    result == Rational -3 4

# Reduce a negative rational number to lowest terms
expect
    result = Rational -4 6 |> reduce
    result == Rational -2 3

# Reduce a rational number with a negative denominator to lowest terms
expect
    result = Rational 3 -9 |> reduce
    result == Rational -1 3

# Reduce zero to lowest terms
expect
    result = Rational 0 6 |> reduce
    result == Rational 0 1

# Reduce an integer to lowest terms
expect
    result = Rational -14 7 |> reduce
    result == Rational -2 1

# Reduce one to lowest terms
expect
    result = Rational 13 13 |> reduce
    result == Rational 1 1

