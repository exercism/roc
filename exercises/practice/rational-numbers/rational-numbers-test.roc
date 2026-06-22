# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rational-numbers/canonical-data.json
# File last updated on 2026-06-22

import RationalNumbers exposing [Rational, add, sub, mul, div, abs, exp, exp_real, reduce]

is_approx_eq = |f1, f2| {
	(f1 * 1e9 + 0.5).to_u64_wrap() == (f2 * 1e9 + 0.5).to_u64_wrap()
}

##
## Arithmetic
##

# Add two positive rational numbers
expect {
	r1 = { num: 1, den: 2 }
	r2 = { num: 2, den: 3 }
	result = r1->add(r2)
	result == { num: 7, den: 6 }
}

# Add a positive rational number and a negative rational number
expect {
	r1 = { num: 1, den: 2 }
	r2 = { num: -2, den: 3 }
	result = r1->add(r2)
	result == { num: -1, den: 6 }
}

# Add two negative rational numbers
expect {
	r1 = { num: -1, den: 2 }
	r2 = { num: -2, den: 3 }
	result = r1->add(r2)
	result == { num: -7, den: 6 }
}

# Add a rational number to its additive inverse
expect {
	r1 = { num: 1, den: 2 }
	r2 = { num: -1, den: 2 }
	result = r1->add(r2)
	result == { num: 0, den: 1 }
}

# Subtract two positive rational numbers
expect {
	r1 = { num: 1, den: 2 }
	r2 = { num: 2, den: 3 }
	result = r1->sub(r2)
	result == { num: -1, den: 6 }
}

# Subtract a positive rational number and a negative rational number
expect {
	r1 = { num: 1, den: 2 }
	r2 = { num: -2, den: 3 }
	result = r1->sub(r2)
	result == { num: 7, den: 6 }
}

# Subtract two negative rational numbers
expect {
	r1 = { num: -1, den: 2 }
	r2 = { num: -2, den: 3 }
	result = r1->sub(r2)
	result == { num: 1, den: 6 }
}

# Subtract a rational number from itself
expect {
	r1 = { num: 1, den: 2 }
	r2 = { num: 1, den: 2 }
	result = r1->sub(r2)
	result == { num: 0, den: 1 }
}

# Multiply two positive rational numbers
expect {
	r1 = { num: 1, den: 2 }
	r2 = { num: 2, den: 3 }
	result = r1->mul(r2)
	result == { num: 1, den: 3 }
}

# Multiply a negative rational number by a positive rational number
expect {
	r1 = { num: -1, den: 2 }
	r2 = { num: 2, den: 3 }
	result = r1->mul(r2)
	result == { num: -1, den: 3 }
}

# Multiply two negative rational numbers
expect {
	r1 = { num: -1, den: 2 }
	r2 = { num: -2, den: 3 }
	result = r1->mul(r2)
	result == { num: 1, den: 3 }
}

# Multiply a rational number by its reciprocal
expect {
	r1 = { num: 1, den: 2 }
	r2 = { num: 2, den: 1 }
	result = r1->mul(r2)
	result == { num: 1, den: 1 }
}

# Multiply a rational number by 1
expect {
	r1 = { num: 1, den: 2 }
	r2 = { num: 1, den: 1 }
	result = r1->mul(r2)
	result == { num: 1, den: 2 }
}

# Multiply a rational number by 0
expect {
	r1 = { num: 1, den: 2 }
	r2 = { num: 0, den: 1 }
	result = r1->mul(r2)
	result == { num: 0, den: 1 }
}

# Divide two positive rational numbers
expect {
	r1 = { num: 1, den: 2 }
	r2 = { num: 2, den: 3 }
	result = r1->div(r2)
	result == { num: 3, den: 4 }
}

# Divide a positive rational number by a negative rational number
expect {
	r1 = { num: 1, den: 2 }
	r2 = { num: -2, den: 3 }
	result = r1->div(r2)
	result == { num: -3, den: 4 }
}

# Divide two negative rational numbers
expect {
	r1 = { num: -1, den: 2 }
	r2 = { num: -2, den: 3 }
	result = r1->div(r2)
	result == { num: 3, den: 4 }
}

# Divide a rational number by 1
expect {
	r1 = { num: 1, den: 2 }
	r2 = { num: 1, den: 1 }
	result = r1->div(r2)
	result == { num: 1, den: 2 }
}

##
## Absolute value
##

# Absolute value of a positive rational number
expect {
	r = { num: 1, den: 2 }
	result = r->abs()
	result == { num: 1, den: 2 }
}

# Absolute value of a positive rational number with negative numerator and denominator
expect {
	r = { num: -1, den: -2 }
	result = r->abs()
	result == { num: 1, den: 2 }
}

# Absolute value of a negative rational number
expect {
	r = { num: -1, den: 2 }
	result = r->abs()
	result == { num: 1, den: 2 }
}

# Absolute value of a negative rational number with negative denominator
expect {
	r = { num: 1, den: -2 }
	result = r->abs()
	result == { num: 1, den: 2 }
}

# Absolute value of zero
expect {
	r = { num: 0, den: 1 }
	result = r->abs()
	result == { num: 0, den: 1 }
}

# Absolute value of a rational number is reduced to lowest terms
expect {
	r = { num: 2, den: 4 }
	result = r->abs()
	result == { num: 1, den: 2 }
}

##
## Exponentiation of a rational number
##

# Raise a positive rational number to a positive integer power
expect {
	r = { num: 1, den: 2 }
	n = 3
	result = r->exp(n)
	result == { num: 1, den: 8 }
}

# Raise a negative rational number to a positive integer power
expect {
	r = { num: -1, den: 2 }
	n = 3
	result = r->exp(n)
	result == { num: -1, den: 8 }
}

# Raise a positive rational number to a negative integer power
expect {
	r = { num: 3, den: 5 }
	n = -2
	result = r->exp(n)
	result == { num: 25, den: 9 }
}

# Raise a negative rational number to an even negative integer power
expect {
	r = { num: -3, den: 5 }
	n = -2
	result = r->exp(n)
	result == { num: 25, den: 9 }
}

# Raise a negative rational number to an odd negative integer power
expect {
	r = { num: -3, den: 5 }
	n = -3
	result = r->exp(n)
	result == { num: -125, den: 27 }
}

# Raise zero to an integer power
expect {
	r = { num: 0, den: 1 }
	n = 5
	result = r->exp(n)
	result == { num: 0, den: 1 }
}

# Raise one to an integer power
expect {
	r = { num: 1, den: 1 }
	n = 4
	result = r->exp(n)
	result == { num: 1, den: 1 }
}

# Raise a positive rational number to the power of zero
expect {
	r = { num: 1, den: 2 }
	n = 0
	result = r->exp(n)
	result == { num: 1, den: 1 }
}

# Raise a negative rational number to the power of zero
expect {
	r = { num: -1, den: 2 }
	n = 0
	result = r->exp(n)
	result == { num: 1, den: 1 }
}

##
## Exponentiation of a real number to a rational number
##

# Raise a real number to a positive rational number
expect {
	r = { num: 4, den: 3 }
	x = 8
	result = x->exp_real(r)
	result->is_approx_eq(16.0.F64)
}

# Raise a real number to a negative rational number
expect {
	r = { num: -1, den: 2 }
	x = 9
	result = x->exp_real(r)
	result->is_approx_eq(0.3333333333333333.F64)
}

# Raise a real number to a zero rational number
expect {
	r = { num: 0, den: 1 }
	x = 2
	result = x->exp_real(r)
	result->is_approx_eq(1.0.F64)
}

##
## Reduction to lowest terms
##

# Reduce a positive rational number to lowest terms
expect {
	r = { num: 2, den: 4 }
	result = r->reduce()
	result == { num: 1, den: 2 }
}

# Reduce places the minus sign on the numerator
expect {
	r = { num: 3, den: -4 }
	result = r->reduce()
	result == { num: -3, den: 4 }
}

# Reduce a negative rational number to lowest terms
expect {
	r = { num: -4, den: 6 }
	result = r->reduce()
	result == { num: -2, den: 3 }
}

# Reduce a rational number with a negative denominator to lowest terms
expect {
	r = { num: 3, den: -9 }
	result = r->reduce()
	result == { num: -1, den: 3 }
}

# Reduce zero to lowest terms
expect {
	r = { num: 0, den: 6 }
	result = r->reduce()
	result == { num: 0, den: 1 }
}

# Reduce an integer to lowest terms
expect {
	r = { num: -14, den: 7 }
	result = r->reduce()
	result == { num: -2, den: 1 }
}

# Reduce one to lowest terms
expect {
	r = { num: 13, den: 13 }
	result = r->reduce()
	result == { num: 1, den: 1 }
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
