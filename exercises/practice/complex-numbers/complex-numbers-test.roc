# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/complex-numbers/canonical-data.json
# File last updated on 2026-06-23

import Complex

###
### Real part
###

# Real part of a purely real number
expect {
	z = Complex.new(1, 0)
	result = z.real
	result->is_approx_eq(1)
}

# Real part of a purely imaginary number
expect {
	z = Complex.new(0, 1)
	result = z.real
	result->is_approx_eq(0)
}

# Real part of a number with real and imaginary part
expect {
	z = Complex.new(1, 2)
	result = z.real
	result->is_approx_eq(1)
}

###
### Imaginary part
###

# Imaginary part of a purely real number
expect {
	z = Complex.new(1, 0)
	result = z.imaginary
	result->is_approx_eq(0)
}

# Imaginary part of a purely imaginary number
expect {
	z = Complex.new(0, 1)
	result = z.imaginary
	result->is_approx_eq(1)
}

# Imaginary part of a number with real and imaginary part
expect {
	z = Complex.new(1, 2)
	result = z.imaginary
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
	z1 = Complex.new(1, 0)
	z2 = Complex.new(2, 0)
	result = z1 + z2
	expected = Complex.new(3, 0)
	result->complex_is_approx_eq(expected)
}

# Add purely imaginary numbers
expect {
	z1 = Complex.new(0, 1)
	z2 = Complex.new(0, 2)
	result = z1 + z2
	expected = Complex.new(0, 3)
	result->complex_is_approx_eq(expected)
}

# Add numbers with real and imaginary part
expect {
	z1 = Complex.new(1, 2)
	z2 = Complex.new(3, 4)
	result = z1 + z2
	expected = Complex.new(4, 6)
	result->complex_is_approx_eq(expected)
}

## Subtraction

# Subtract purely real numbers
expect {
	z1 = Complex.new(1, 0)
	z2 = Complex.new(2, 0)
	result = z1 - z2
	expected = Complex.new(-1, 0)
	result->complex_is_approx_eq(expected)
}

# Subtract purely imaginary numbers
expect {
	z1 = Complex.new(0, 1)
	z2 = Complex.new(0, 2)
	result = z1 - z2
	expected = Complex.new(0, -1)
	result->complex_is_approx_eq(expected)
}

# Subtract numbers with real and imaginary part
expect {
	z1 = Complex.new(1, 2)
	z2 = Complex.new(3, 4)
	result = z1 - z2
	expected = Complex.new(-2, -2)
	result->complex_is_approx_eq(expected)
}

## Multiplication

# Multiply purely real numbers
expect {
	z1 = Complex.new(1, 0)
	z2 = Complex.new(2, 0)
	result = z1 * z2
	expected = Complex.new(2, 0)
	result->complex_is_approx_eq(expected)
}

# Multiply purely imaginary numbers
expect {
	z1 = Complex.new(0, 1)
	z2 = Complex.new(0, 2)
	result = z1 * z2
	expected = Complex.new(-2, 0)
	result->complex_is_approx_eq(expected)
}

# Multiply numbers with real and imaginary part
expect {
	z1 = Complex.new(1, 2)
	z2 = Complex.new(3, 4)
	result = z1 * z2
	expected = Complex.new(-5, 10)
	result->complex_is_approx_eq(expected)
}

## Division

# Divide purely real numbers
expect {
	z1 = Complex.new(1, 0)
	z2 = Complex.new(2, 0)
	result = z1 / z2
	expected = Complex.new(0.5, 0)
	result->complex_is_approx_eq(expected)
}

# Divide purely imaginary numbers
expect {
	z1 = Complex.new(0, 1)
	z2 = Complex.new(0, 2)
	result = z1 / z2
	expected = Complex.new(0.5, 0)
	result->complex_is_approx_eq(expected)
}

# Divide numbers with real and imaginary part
expect {
	z1 = Complex.new(1, 2)
	z2 = Complex.new(3, 4)
	result = z1 / z2
	expected = Complex.new(0.44, 0.08)
	result->complex_is_approx_eq(expected)
}

###
### Absolute value
###

# Absolute value of a positive purely real number
expect {
	z = Complex.new(5, 0)
	result = z.abs()
	result->is_approx_eq(5)
}

# Absolute value of a negative purely real number
expect {
	z = Complex.new(-5, 0)
	result = z.abs()
	result->is_approx_eq(5)
}

# Absolute value of a purely imaginary number with positive imaginary part
expect {
	z = Complex.new(0, 5)
	result = z.abs()
	result->is_approx_eq(5)
}

# Absolute value of a purely imaginary number with negative imaginary part
expect {
	z = Complex.new(0, -5)
	result = z.abs()
	result->is_approx_eq(5)
}

# Absolute value of a number with real and imaginary part
expect {
	z = Complex.new(3, 4)
	result = z.abs()
	result->is_approx_eq(5)
}

###
### Complex conjugate
###

# Conjugate a purely real number
expect {
	z = Complex.new(5, 0)
	result = z.conjugate()
	expected = Complex.new(5, 0)
	result->complex_is_approx_eq(expected)
}

# Conjugate a purely imaginary number
expect {
	z = Complex.new(0, 5)
	result = z.conjugate()
	expected = Complex.new(0, -5)
	result->complex_is_approx_eq(expected)
}

# Conjugate a number with real and imaginary part
expect {
	z = Complex.new(1, 1)
	result = z.conjugate()
	expected = Complex.new(1, -1)
	result->complex_is_approx_eq(expected)
}

###
### Complex exponential function
###

# Euler's identity/formula
expect {
	z = Complex.new(0, 3.141592653589793.F64)
	result = z.exp()
	expected = Complex.new(-1, 0)
	result->complex_is_approx_eq(expected)
}

# Exponential of 0
expect {
	z = Complex.new(0, 0)
	result = z.exp()
	expected = Complex.new(1, 0)
	result->complex_is_approx_eq(expected)
}

# Exponential of a purely real number
expect {
	z = Complex.new(1, 0)
	result = z.exp()
	expected = Complex.new(2.718281828459045.F64, 0)
	result->complex_is_approx_eq(expected)
}

# Exponential of a number with real and imaginary part
expect {
	z = Complex.new(0.6931471805599453.F64, 3.141592653589793.F64)
	result = z.exp()
	expected = Complex.new(-2, 0)
	result->complex_is_approx_eq(expected)
}

# Exponential resulting in a number with real and imaginary part
expect {
	z = Complex.new(0.6931471805599453.F64 / 2, 3.141592653589793.F64 / 4)
	result = z.exp()
	expected = Complex.new(1, 1)
	result->complex_is_approx_eq(expected)
}

###
### Operations between real numbers and complex numbers
###

# Add real number to complex number
expect {
	z1 = Complex.new(1, 2)
	z2 = Complex.new(5, 0)
	result = z1 + z2
	expected = Complex.new(6, 2)
	result->complex_is_approx_eq(expected)
}

# Add complex number to real number
expect {
	z1 = Complex.new(5, 0)
	z2 = Complex.new(1, 2)
	result = z1 + z2
	expected = Complex.new(6, 2)
	result->complex_is_approx_eq(expected)
}

# Subtract real number from complex number
expect {
	z1 = Complex.new(5, 7)
	z2 = Complex.new(4, 0)
	result = z1 - z2
	expected = Complex.new(1, 7)
	result->complex_is_approx_eq(expected)
}

# Subtract complex number from real number
expect {
	z1 = Complex.new(4, 0)
	z2 = Complex.new(5, 7)
	result = z1 - z2
	expected = Complex.new(-1, -7)
	result->complex_is_approx_eq(expected)
}

# Multiply complex number by real number
expect {
	z1 = Complex.new(2, 5)
	z2 = Complex.new(5, 0)
	result = z1 * z2
	expected = Complex.new(10, 25)
	result->complex_is_approx_eq(expected)
}

# Multiply real number by complex number
expect {
	z1 = Complex.new(5, 0)
	z2 = Complex.new(2, 5)
	result = z1 * z2
	expected = Complex.new(10, 25)
	result->complex_is_approx_eq(expected)
}

# Divide complex number by real number
expect {
	z1 = Complex.new(10, 100)
	z2 = Complex.new(10, 0)
	result = z1 / z2
	expected = Complex.new(1, 10)
	result->complex_is_approx_eq(expected)
}

# Divide real number by complex number
expect {
	z1 = Complex.new(5, 0)
	z2 = Complex.new(1, 1)
	result = z1 / z2
	expected = Complex.new(2.5, -2.5)
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
	is_approx_eq(z1.real, z2.real) and is_approx_eq(z1.imaginary, z2.imaginary)
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
