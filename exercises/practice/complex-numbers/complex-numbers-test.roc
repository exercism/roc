# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/complex-numbers/canonical-data.json
# File last updated on 2024-09-21
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import ComplexNumbers exposing [real, imaginary, add, sub, mul, div, conjugate, abs, exp]

isApproxEq = \z1, z2 ->
    z1.re |> Num.isApproxEq z2.re {} && z1.im |> Num.isApproxEq z2.im {}

###
### Real part
###

# Real part of a purely real number
expect
    z = { re: 1, im: 0 }
    result = real z
    result |> Num.isApproxEq 1 {}

# Real part of a purely imaginary number
expect
    z = { re: 0, im: 1 }
    result = real z
    result |> Num.isApproxEq 0 {}

# Real part of a number with real and imaginary part
expect
    z = { re: 1, im: 2 }
    result = real z
    result |> Num.isApproxEq 1 {}

###
### Imaginary part
###

# Imaginary part of a purely real number
expect
    z = { re: 1, im: 0 }
    result = imaginary z
    result |> Num.isApproxEq 0 {}

# Imaginary part of a purely imaginary number
expect
    z = { re: 0, im: 1 }
    result = imaginary z
    result |> Num.isApproxEq 1 {}

# Imaginary part of a number with real and imaginary part
expect
    z = { re: 1, im: 2 }
    result = imaginary z
    result |> Num.isApproxEq 2 {}

###
### Imaginary unit
###

###
### Arithmetic
###

## Addition

# Add purely real numbers
expect
    z1 = { re: 1, im: 0 }
    z2 = { re: 2, im: 0 }
    result = z1 |> add z2
    expected = { re: 3, im: 0 }
    result |> isApproxEq expected

# Add purely imaginary numbers
expect
    z1 = { re: 0, im: 1 }
    z2 = { re: 0, im: 2 }
    result = z1 |> add z2
    expected = { re: 0, im: 3 }
    result |> isApproxEq expected

# Add numbers with real and imaginary part
expect
    z1 = { re: 1, im: 2 }
    z2 = { re: 3, im: 4 }
    result = z1 |> add z2
    expected = { re: 4, im: 6 }
    result |> isApproxEq expected

## Subtraction

# Subtract purely real numbers
expect
    z1 = { re: 1, im: 0 }
    z2 = { re: 2, im: 0 }
    result = z1 |> sub z2
    expected = { re: -1, im: 0 }
    result |> isApproxEq expected

# Subtract purely imaginary numbers
expect
    z1 = { re: 0, im: 1 }
    z2 = { re: 0, im: 2 }
    result = z1 |> sub z2
    expected = { re: 0, im: -1 }
    result |> isApproxEq expected

# Subtract numbers with real and imaginary part
expect
    z1 = { re: 1, im: 2 }
    z2 = { re: 3, im: 4 }
    result = z1 |> sub z2
    expected = { re: -2, im: -2 }
    result |> isApproxEq expected

## Multiplication

# Multiply purely real numbers
expect
    z1 = { re: 1, im: 0 }
    z2 = { re: 2, im: 0 }
    result = z1 |> mul z2
    expected = { re: 2, im: 0 }
    result |> isApproxEq expected

# Multiply purely imaginary numbers
expect
    z1 = { re: 0, im: 1 }
    z2 = { re: 0, im: 2 }
    result = z1 |> mul z2
    expected = { re: -2, im: 0 }
    result |> isApproxEq expected

# Multiply numbers with real and imaginary part
expect
    z1 = { re: 1, im: 2 }
    z2 = { re: 3, im: 4 }
    result = z1 |> mul z2
    expected = { re: -5, im: 10 }
    result |> isApproxEq expected

## Division

# Divide purely real numbers
expect
    z1 = { re: 1, im: 0 }
    z2 = { re: 2, im: 0 }
    result = z1 |> div z2
    expected = { re: 0.5, im: 0 }
    result |> isApproxEq expected

# Divide purely imaginary numbers
expect
    z1 = { re: 0, im: 1 }
    z2 = { re: 0, im: 2 }
    result = z1 |> div z2
    expected = { re: 0.5, im: 0 }
    result |> isApproxEq expected

# Divide numbers with real and imaginary part
expect
    z1 = { re: 1, im: 2 }
    z2 = { re: 3, im: 4 }
    result = z1 |> div z2
    expected = { re: 0.44, im: 0.08 }
    result |> isApproxEq expected

###
### Absolute value
###

# Absolute value of a positive purely real number
expect
    z = { re: 5, im: 0 }
    result = abs z
    result |> Num.isApproxEq 5 {}

# Absolute value of a negative purely real number
expect
    z = { re: -5, im: 0 }
    result = abs z
    result |> Num.isApproxEq 5 {}

# Absolute value of a purely imaginary number with positive imaginary part
expect
    z = { re: 0, im: 5 }
    result = abs z
    result |> Num.isApproxEq 5 {}

# Absolute value of a purely imaginary number with negative imaginary part
expect
    z = { re: 0, im: -5 }
    result = abs z
    result |> Num.isApproxEq 5 {}

# Absolute value of a number with real and imaginary part
expect
    z = { re: 3, im: 4 }
    result = abs z
    result |> Num.isApproxEq 5 {}

###
### Complex conjugate
###

# Conjugate a purely real number
expect
    z = { re: 5, im: 0 }
    result = conjugate z
    expected = { re: 5, im: 0 }
    result |> isApproxEq expected

# Conjugate a purely imaginary number
expect
    z = { re: 0, im: 5 }
    result = conjugate z
    expected = { re: 0, im: -5 }
    result |> isApproxEq expected

# Conjugate a number with real and imaginary part
expect
    z = { re: 1, im: 1 }
    result = conjugate z
    expected = { re: 1, im: -1 }
    result |> isApproxEq expected

###
### Complex exponential function
###

# Euler's identity/formula
expect
    z = { re: 0, im: Num.pi }
    result = exp z
    expected = { re: -1, im: 0 }
    result |> isApproxEq expected

# Exponential of 0
expect
    z = { re: 0, im: 0 }
    result = exp z
    expected = { re: 1, im: 0 }
    result |> isApproxEq expected

# Exponential of a purely real number
expect
    z = { re: 1, im: 0 }
    result = exp z
    expected = { re: Num.e, im: 0 }
    result |> isApproxEq expected

# Exponential of a number with real and imaginary part
expect
    z = { re: Num.log 2f64, im: Num.pi }
    result = exp z
    expected = { re: -2, im: 0 }
    result |> isApproxEq expected

# Exponential resulting in a number with real and imaginary part
expect
    z = { re: Num.log 2f64 / 2, im: Num.pi / 4 }
    result = exp z
    expected = { re: 1, im: 1 }
    result |> isApproxEq expected

###
### Operations between real numbers and complex numbers
###

# Add real number to complex number
expect
    z1 = { re: 1, im: 2 }
    z2 = { re: 5, im: 0 }
    result = z1 |> add z2
    expected = { re: 6, im: 2 }
    result |> isApproxEq expected

# Add complex number to real number
expect
    z1 = { re: 5, im: 0 }
    z2 = { re: 1, im: 2 }
    result = z1 |> add z2
    expected = { re: 6, im: 2 }
    result |> isApproxEq expected

# Subtract real number from complex number
expect
    z1 = { re: 5, im: 7 }
    z2 = { re: 4, im: 0 }
    result = z1 |> sub z2
    expected = { re: 1, im: 7 }
    result |> isApproxEq expected

# Subtract complex number from real number
expect
    z1 = { re: 4, im: 0 }
    z2 = { re: 5, im: 7 }
    result = z1 |> sub z2
    expected = { re: -1, im: -7 }
    result |> isApproxEq expected

# Multiply complex number by real number
expect
    z1 = { re: 2, im: 5 }
    z2 = { re: 5, im: 0 }
    result = z1 |> mul z2
    expected = { re: 10, im: 25 }
    result |> isApproxEq expected

# Multiply real number by complex number
expect
    z1 = { re: 5, im: 0 }
    z2 = { re: 2, im: 5 }
    result = z1 |> mul z2
    expected = { re: 10, im: 25 }
    result |> isApproxEq expected

# Divide complex number by real number
expect
    z1 = { re: 10, im: 100 }
    z2 = { re: 10, im: 0 }
    result = z1 |> div z2
    expected = { re: 1, im: 10 }
    result |> isApproxEq expected

# Divide real number by complex number
expect
    z1 = { re: 5, im: 0 }
    z2 = { re: 1, im: 1 }
    result = z1 |> div z2
    expected = { re: 2.5, im: -2.5 }
    result |> isApproxEq expected

