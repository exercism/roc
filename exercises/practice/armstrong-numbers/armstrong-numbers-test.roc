# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/armstrong-numbers/canonical-data.json
# File last updated on 2026-06-13

import ArmstrongNumbers exposing [is_armstrong_number]

# Zero is an Armstrong number
expect {
	result = is_armstrong_number(0)
	result == Bool.True
}

# Single-digit numbers are Armstrong numbers
expect {
	result = is_armstrong_number(5)
	result == Bool.True
}

# There are no two-digit Armstrong numbers
expect {
	result = is_armstrong_number(10)
	result == Bool.False
}

# Three-digit number that is an Armstrong number
expect {
	result = is_armstrong_number(153)
	result == Bool.True
}

# Three-digit number that is not an Armstrong number
expect {
	result = is_armstrong_number(100)
	result == Bool.False
}

# Four-digit number that is an Armstrong number
expect {
	result = is_armstrong_number(9474)
	result == Bool.True
}

# Four-digit number that is not an Armstrong number
expect {
	result = is_armstrong_number(9475)
	result == Bool.False
}

# Seven-digit number that is an Armstrong number
expect {
	result = is_armstrong_number(9926315)
	result == Bool.True
}

# Seven-digit number that is not an Armstrong number
expect {
	result = is_armstrong_number(9926314)
	result == Bool.False
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
