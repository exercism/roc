# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/complex-numbers/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import ComplexNumbers exposing [real, imaginary, add, sub, mul, div, conjugate, abs, exp]

is_approx_eq = |z1, z2|
    z1.re |> Num.is_approx_eq(z2.re, {}) and z1.im |> Num.is_approx_eq(z2.im, {})

###
### Real part
###

# Real part of a purely real number
expect
    z = { re: 1, im: 0 }
    result = real(z)
    result |> Num.is_approx_eq(1, {})

# Real part of a purely imaginary number
expect
    z = { re: 0, im: 1 }
    result = real(z)
    result |> Num.is_approx_eq(0, {})

# Real part of a number with real and imaginary part
expect
    z = { re: 1, im: 2 }
    result = real(z)
    result |> Num.is_approx_eq(1, {})

###
### Imaginary part
###

# Imaginary part of a purely real number
expect
    z = { re: 1, im: 0 }
    result = imaginary(z)
    result |> Num.is_approx_eq(0, {})

# Imaginary part of a purely imaginary number
expect
    z = { re: 0, im: 1 }
    result = imaginary(z)
    result |> Num.is_approx_eq(1, {})

# Imaginary part of a number with real and imaginary part
expect
    z = { re: 1, im: 2 }
    result = imaginary(z)
    result |> Num.is_approx_eq(2, {})

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
    result = z1 |> add(z2)
    expected = { re: 3, im: 0 }
    result |> is_approx_eq(expected)

# Add purely imaginary numbers
expect
    z1 = { re: 0, im: 1 }
    z2 = { re: 0, im: 2 }
    result = z1 |> add(z2)
    expected = { re: 0, im: 3 }
    result |> is_approx_eq(expected)

# Add numbers with real and imaginary part
expect
    z1 = { re: 1, im: 2 }
    z2 = { re: 3, im: 4 }
    result = z1 |> add(z2)
    expected = { re: 4, im: 6 }
    result |> is_approx_eq(expected)

## Subtraction

# Subtract purely real numbers
expect
    z1 = { re: 1, im: 0 }
    z2 = { re: 2, im: 0 }
    result = z1 |> sub(z2)
    expected = { re: -1, im: 0 }
    result |> is_approx_eq(expected)

# Subtract purely imaginary numbers
expect
    z1 = { re: 0, im: 1 }
    z2 = { re: 0, im: 2 }
    result = z1 |> sub(z2)
    expected = { re: 0, im: -1 }
    result |> is_approx_eq(expected)

# Subtract numbers with real and imaginary part
expect
    z1 = { re: 1, im: 2 }
    z2 = { re: 3, im: 4 }
    result = z1 |> sub(z2)
    expected = { re: -2, im: -2 }
    result |> is_approx_eq(expected)

## Multiplication

# Multiply purely real numbers
expect
    z1 = { re: 1, im: 0 }
    z2 = { re: 2, im: 0 }
    result = z1 |> mul(z2)
    expected = { re: 2, im: 0 }
    result |> is_approx_eq(expected)

# Multiply purely imaginary numbers
expect
    z1 = { re: 0, im: 1 }
    z2 = { re: 0, im: 2 }
    result = z1 |> mul(z2)
    expected = { re: -2, im: 0 }
    result |> is_approx_eq(expected)

# Multiply numbers with real and imaginary part
expect
    z1 = { re: 1, im: 2 }
    z2 = { re: 3, im: 4 }
    result = z1 |> mul(z2)
    expected = { re: -5, im: 10 }
    result |> is_approx_eq(expected)

## Division

# Divide purely real numbers
expect
    z1 = { re: 1, im: 0 }
    z2 = { re: 2, im: 0 }
    result = z1 |> div(z2)
    expected = { re: 0.5, im: 0 }
    result |> is_approx_eq(expected)

# Divide purely imaginary numbers
expect
    z1 = { re: 0, im: 1 }
    z2 = { re: 0, im: 2 }
    result = z1 |> div(z2)
    expected = { re: 0.5, im: 0 }
    result |> is_approx_eq(expected)

# Divide numbers with real and imaginary part
expect
    z1 = { re: 1, im: 2 }
    z2 = { re: 3, im: 4 }
    result = z1 |> div(z2)
    expected = { re: 0.44, im: 0.08 }
    result |> is_approx_eq(expected)

###
### Absolute value
###

# Absolute value of a positive purely real number
expect
    z = { re: 5, im: 0 }
    result = abs(z)
    result |> Num.is_approx_eq(5, {})

# Absolute value of a negative purely real number
expect
    z = { re: -5, im: 0 }
    result = abs(z)
    result |> Num.is_approx_eq(5, {})

# Absolute value of a purely imaginary number with positive imaginary part
expect
    z = { re: 0, im: 5 }
    result = abs(z)
    result |> Num.is_approx_eq(5, {})

# Absolute value of a purely imaginary number with negative imaginary part
expect
    z = { re: 0, im: -5 }
    result = abs(z)
    result |> Num.is_approx_eq(5, {})

# Absolute value of a number with real and imaginary part
expect
    z = { re: 3, im: 4 }
    result = abs(z)
    result |> Num.is_approx_eq(5, {})

###
### Complex conjugate
###

# Conjugate a purely real number
expect
    z = { re: 5, im: 0 }
    result = conjugate(z)
    expected = { re: 5, im: 0 }
    result |> is_approx_eq(expected)

# Conjugate a purely imaginary number
expect
    z = { re: 0, im: 5 }
    result = conjugate(z)
    expected = { re: 0, im: -5 }
    result |> is_approx_eq(expected)

# Conjugate a number with real and imaginary part
expect
    z = { re: 1, im: 1 }
    result = conjugate(z)
    expected = { re: 1, im: -1 }
    result |> is_approx_eq(expected)

###
### Complex exponential function
###

# Euler's identity/formula
expect
    z = { re: 0, im: Num.pi }
    result = exp(z)
    expected = { re: -1, im: 0 }
    result |> is_approx_eq(expected)

# Exponential of 0
expect
    z = { re: 0, im: 0 }
    result = exp(z)
    expected = { re: 1, im: 0 }
    result |> is_approx_eq(expected)

# Exponential of a purely real number
expect
    z = { re: 1, im: 0 }
    result = exp(z)
    expected = { re: Num.e, im: 0 }
    result |> is_approx_eq(expected)

# Exponential of a number with real and imaginary part
expect
    z = { re: Num.log(2f64), im: Num.pi }
    result = exp(z)
    expected = { re: -2, im: 0 }
    result |> is_approx_eq(expected)

# Exponential resulting in a number with real and imaginary part
expect
    z = { re: Num.log(2f64) / 2, im: Num.pi / 4 }
    result = exp(z)
    expected = { re: 1, im: 1 }
    result |> is_approx_eq(expected)

###
### Operations between real numbers and complex numbers
###

# Add real number to complex number
expect
    z1 = { re: 1, im: 2 }
    z2 = { re: 5, im: 0 }
    result = z1 |> add(z2)
    expected = { re: 6, im: 2 }
    result |> is_approx_eq(expected)

# Add complex number to real number
expect
    z1 = { re: 5, im: 0 }
    z2 = { re: 1, im: 2 }
    result = z1 |> add(z2)
    expected = { re: 6, im: 2 }
    result |> is_approx_eq(expected)

# Subtract real number from complex number
expect
    z1 = { re: 5, im: 7 }
    z2 = { re: 4, im: 0 }
    result = z1 |> sub(z2)
    expected = { re: 1, im: 7 }
    result |> is_approx_eq(expected)

# Subtract complex number from real number
expect
    z1 = { re: 4, im: 0 }
    z2 = { re: 5, im: 7 }
    result = z1 |> sub(z2)
    expected = { re: -1, im: -7 }
    result |> is_approx_eq(expected)

# Multiply complex number by real number
expect
    z1 = { re: 2, im: 5 }
    z2 = { re: 5, im: 0 }
    result = z1 |> mul(z2)
    expected = { re: 10, im: 25 }
    result |> is_approx_eq(expected)

# Multiply real number by complex number
expect
    z1 = { re: 5, im: 0 }
    z2 = { re: 2, im: 5 }
    result = z1 |> mul(z2)
    expected = { re: 10, im: 25 }
    result |> is_approx_eq(expected)

# Divide complex number by real number
expect
    z1 = { re: 10, im: 100 }
    z2 = { re: 10, im: 0 }
    result = z1 |> div(z2)
    expected = { re: 1, im: 10 }
    result |> is_approx_eq(expected)

# Divide real number by complex number
expect
    z1 = { re: 5, im: 0 }
    z2 = { re: 1, im: 1 }
    result = z1 |> div(z2)
    expected = { re: 2.5, im: -2.5 }
    result |> is_approx_eq(expected)

