# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/complex-numbers/canonical-data.json
# File last updated on 2026-06-21

import ComplexNumbers exposing [Complex, real, imaginary, add, sub, mul, div, conjugate, abs, exp]

###
### Real part
###

# Real part of a purely real number
expect {
	z = { re: 1, im: 0 }
	result = real(z)
	result->is_approx_eq(1)
}

# Real part of a purely imaginary number
expect {
	z = { re: 0, im: 1 }
	result = real(z)
	result->is_approx_eq(0)
}

# Real part of a number with real and imaginary part
expect {
	z = { re: 1, im: 2 }
	result = real(z)
	result->is_approx_eq(1)
}

###
### Imaginary part
###

# Imaginary part of a purely real number
expect {
	z = { re: 1, im: 0 }
	result = imaginary(z)
	result->is_approx_eq(0)
}

# Imaginary part of a purely imaginary number
expect {
	z = { re: 0, im: 1 }
	result = imaginary(z)
	result->is_approx_eq(1)
}

# Imaginary part of a number with real and imaginary part
expect {
	z = { re: 1, im: 2 }
	result = imaginary(z)
	result->is_approx_eq(2)
}

###
### Imaginary unit
###

###
### Arithmetic
###

## Addition

# Add purely real numbers
expect {
	z1 = { re: 1, im: 0 }
	z2 = { re: 2, im: 0 }
	result = add(z1, z2)
	expected = { re: 3, im: 0 }
	result->complex_is_approx_eq(expected)
}

# Add purely imaginary numbers
expect {
	z1 = { re: 0, im: 1 }
	z2 = { re: 0, im: 2 }
	result = add(z1, z2)
	expected = { re: 0, im: 3 }
	result->complex_is_approx_eq(expected)
}

# Add numbers with real and imaginary part
expect {
	z1 = { re: 1, im: 2 }
	z2 = { re: 3, im: 4 }
	result = add(z1, z2)
	expected = { re: 4, im: 6 }
	result->complex_is_approx_eq(expected)
}

## Subtraction

# Subtract purely real numbers
expect {
	z1 = { re: 1, im: 0 }
	z2 = { re: 2, im: 0 }
	result = sub(z1, z2)
	expected = { re: -1, im: 0 }
	result->complex_is_approx_eq(expected)
}

# Subtract purely imaginary numbers
expect {
	z1 = { re: 0, im: 1 }
	z2 = { re: 0, im: 2 }
	result = sub(z1, z2)
	expected = { re: 0, im: -1 }
	result->complex_is_approx_eq(expected)
}

# Subtract numbers with real and imaginary part
expect {
	z1 = { re: 1, im: 2 }
	z2 = { re: 3, im: 4 }
	result = sub(z1, z2)
	expected = { re: -2, im: -2 }
	result->complex_is_approx_eq(expected)
}

## Multiplication

# Multiply purely real numbers
expect {
	z1 = { re: 1, im: 0 }
	z2 = { re: 2, im: 0 }
	result = mul(z1, z2)
	expected = { re: 2, im: 0 }
	result->complex_is_approx_eq(expected)
}

# Multiply purely imaginary numbers
expect {
	z1 = { re: 0, im: 1 }
	z2 = { re: 0, im: 2 }
	result = mul(z1, z2)
	expected = { re: -2, im: 0 }
	result->complex_is_approx_eq(expected)
}

# Multiply numbers with real and imaginary part
expect {
	z1 = { re: 1, im: 2 }
	z2 = { re: 3, im: 4 }
	result = mul(z1, z2)
	expected = { re: -5, im: 10 }
	result->complex_is_approx_eq(expected)
}

## Division

# Divide purely real numbers
expect {
	z1 = { re: 1, im: 0 }
	z2 = { re: 2, im: 0 }
	result = div(z1, z2)
	expected = { re: 0.5, im: 0 }
	result->complex_is_approx_eq(expected)
}

# Divide purely imaginary numbers
expect {
	z1 = { re: 0, im: 1 }
	z2 = { re: 0, im: 2 }
	result = div(z1, z2)
	expected = { re: 0.5, im: 0 }
	result->complex_is_approx_eq(expected)
}

# Divide numbers with real and imaginary part
expect {
	z1 = { re: 1, im: 2 }
	z2 = { re: 3, im: 4 }
	result = div(z1, z2)
	expected = { re: 0.44, im: 0.08 }
	result->complex_is_approx_eq(expected)
}

###
### Absolute value
###

# Absolute value of a positive purely real number
expect {
	z = { re: 5, im: 0 }
	result = abs(z)
	result->is_approx_eq(5)
}

# Absolute value of a negative purely real number
expect {
	z = { re: -5, im: 0 }
	result = abs(z)
	result->is_approx_eq(5)
}

# Absolute value of a purely imaginary number with positive imaginary part
expect {
	z = { re: 0, im: 5 }
	result = abs(z)
	result->is_approx_eq(5)
}

# Absolute value of a purely imaginary number with negative imaginary part
expect {
	z = { re: 0, im: -5 }
	result = abs(z)
	result->is_approx_eq(5)
}

# Absolute value of a number with real and imaginary part
expect {
	z = { re: 3, im: 4 }
	result = abs(z)
	result->is_approx_eq(5)
}

###
### Complex conjugate
###

# Conjugate a purely real number
expect {
	z = { re: 5, im: 0 }
	result = conjugate(z)
	expected = { re: 5, im: 0 }
	result->complex_is_approx_eq(expected)
}

# Conjugate a purely imaginary number
expect {
	z = { re: 0, im: 5 }
	result = conjugate(z)
	expected = { re: 0, im: -5 }
	result->complex_is_approx_eq(expected)
}

# Conjugate a number with real and imaginary part
expect {
	z = { re: 1, im: 1 }
	result = conjugate(z)
	expected = { re: 1, im: -1 }
	result->complex_is_approx_eq(expected)
}

###
### Complex exponential function
###

# Euler's identity/formula
expect {
	z = { re: 0, im: 3.141592653589793.F64 }
	result = exp(z)
	expected = { re: -1, im: 0 }
	result->complex_is_approx_eq(expected)
}

# Exponential of 0
expect {
	z = { re: 0, im: 0 }
	result = exp(z)
	expected = { re: 1, im: 0 }
	result->complex_is_approx_eq(expected)
}

# Exponential of a purely real number
expect {
	z = { re: 1, im: 0 }
	result = exp(z)
	expected = { re: 2.718281828459045.F64, im: 0 }
	result->complex_is_approx_eq(expected)
}

# Exponential of a number with real and imaginary part
expect {
	z = { re: 0.6931471805599453.F64, im: 3.141592653589793.F64 }
	result = exp(z)
	expected = { re: -2, im: 0 }
	result->complex_is_approx_eq(expected)
}

# Exponential resulting in a number with real and imaginary part
expect {
	z = { re: 0.6931471805599453.F64 / 2, im: 3.141592653589793.F64 / 4 }
	result = exp(z)
	expected = { re: 1, im: 1 }
	result->complex_is_approx_eq(expected)
}

###
### Operations between real numbers and complex numbers
###

# Add real number to complex number
expect {
	z1 = { re: 1, im: 2 }
	z2 = { re: 5, im: 0 }
	result = add(z1, z2)
	expected = { re: 6, im: 2 }
	result->complex_is_approx_eq(expected)
}

# Add complex number to real number
expect {
	z1 = { re: 5, im: 0 }
	z2 = { re: 1, im: 2 }
	result = add(z1, z2)
	expected = { re: 6, im: 2 }
	result->complex_is_approx_eq(expected)
}

# Subtract real number from complex number
expect {
	z1 = { re: 5, im: 7 }
	z2 = { re: 4, im: 0 }
	result = sub(z1, z2)
	expected = { re: 1, im: 7 }
	result->complex_is_approx_eq(expected)
}

# Subtract complex number from real number
expect {
	z1 = { re: 4, im: 0 }
	z2 = { re: 5, im: 7 }
	result = sub(z1, z2)
	expected = { re: -1, im: -7 }
	result->complex_is_approx_eq(expected)
}

# Multiply complex number by real number
expect {
	z1 = { re: 2, im: 5 }
	z2 = { re: 5, im: 0 }
	result = mul(z1, z2)
	expected = { re: 10, im: 25 }
	result->complex_is_approx_eq(expected)
}

# Multiply real number by complex number
expect {
	z1 = { re: 5, im: 0 }
	z2 = { re: 2, im: 5 }
	result = mul(z1, z2)
	expected = { re: 10, im: 25 }
	result->complex_is_approx_eq(expected)
}

# Divide complex number by real number
expect {
	z1 = { re: 10, im: 100 }
	z2 = { re: 10, im: 0 }
	result = div(z1, z2)
	expected = { re: 1, im: 10 }
	result->complex_is_approx_eq(expected)
}

# Divide real number by complex number
expect {
	z1 = { re: 5, im: 0 }
	z2 = { re: 1, im: 1 }
	result = div(z1, z2)
	expected = { re: 2.5, im: -2.5 }
	result->complex_is_approx_eq(expected)
}

is_approx_eq = |x1, x2| {
	i1 = (x1 * 1000 + 0.5).to_i64_try() ?? {
		crash "Unreachable"
	}
	i2 = (x2 * 1000 + 0.5).to_i64_try() ?? {
		crash "Unreachable"
	}
	i1 == i2
}

complex_is_approx_eq = |z1, z2| {
	is_approx_eq(z1.re, z2.re) and is_approx_eq(z1.im, z2.im)
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
