# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/luhn/canonical-data.json
# File last updated on 2026-06-13

import Luhn exposing [valid]

# single digit strings can not be valid
expect {
	result = valid("1")
	result == Bool.False
}

# a single zero is invalid
expect {
	result = valid("0")
	result == Bool.False
}

# a simple valid SIN that remains valid if reversed
expect {
	result = valid("059")
	result == Bool.True
}

# a simple valid SIN that becomes invalid if reversed
expect {
	result = valid("59")
	result == Bool.True
}

# a valid Canadian SIN
expect {
	result = valid("055 444 285")
	result == Bool.True
}

# invalid Canadian SIN
expect {
	result = valid("055 444 286")
	result == Bool.False
}

# invalid credit card
expect {
	result = valid("8273 1232 7352 0569")
	result == Bool.False
}

# invalid long number with an even remainder
expect {
	result = valid("1 2345 6789 1234 5678 9012")
	result == Bool.False
}

# invalid long number with a remainder divisible by 5
expect {
	result = valid("1 2345 6789 1234 5678 9013")
	result == Bool.False
}

# valid number with an even number of digits
expect {
	result = valid("095 245 88")
	result == Bool.True
}

# valid number with an odd number of spaces
expect {
	result = valid("234 567 891 234")
	result == Bool.True
}

# valid strings with a non-digit added at the end become invalid
expect {
	result = valid("059a")
	result == Bool.False
}

# valid strings with punctuation included become invalid
expect {
	result = valid("055-444-285")
	result == Bool.False
}

# valid strings with symbols included become invalid
expect {
	result = valid("055# 444$ 285")
	result == Bool.False
}

# single zero with space is invalid
expect {
	result = valid(" 0")
	result == Bool.False
}

# more than a single zero is valid
expect {
	result = valid("0000 0")
	result == Bool.True
}

# input digit 9 is correctly converted to output digit 9
expect {
	result = valid("091")
	result == Bool.True
}

# very long input is valid
expect {
	result = valid("9999999999 9999999999 9999999999 9999999999")
	result == Bool.True
}

# valid luhn with an odd number of digits and non zero first digit
expect {
	result = valid("109")
	result == Bool.True
}

# using ascii value for non-doubled non-digit isn't allowed
expect {
	result = valid("055b 444 285")
	result == Bool.False
}

# using ascii value for doubled non-digit isn't allowed
expect {
	result = valid(":9")
	result == Bool.False
}

# non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed
expect {
	result = valid("59%59")
	result == Bool.False
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
