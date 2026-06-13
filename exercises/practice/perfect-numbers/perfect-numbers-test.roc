# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/perfect-numbers/canonical-data.json
# File last updated on 2026-06-13

import PerfectNumbers exposing [classify]

##
## Perfect numbers
##

# Smallest perfect number is classified correctly
expect {
	result = classify(6)
	result == Ok(Perfect)
}

# Medium perfect number is classified correctly
expect {
	result = classify(28)
	result == Ok(Perfect)
}

# Large perfect number is classified correctly
expect {
	result = classify(33550336)
	result == Ok(Perfect)
}

##
## Abundant numbers
##

# Smallest abundant number is classified correctly
expect {
	result = classify(12)
	result == Ok(Abundant)
}

# Medium abundant number is classified correctly
expect {
	result = classify(30)
	result == Ok(Abundant)
}

# Large abundant number is classified correctly
expect {
	result = classify(33550335)
	result == Ok(Abundant)
}

##
## Deficient numbers
##

# Smallest prime deficient number is classified correctly
expect {
	result = classify(2)
	result == Ok(Deficient)
}

# Smallest non-prime deficient number is classified correctly
expect {
	result = classify(4)
	result == Ok(Deficient)
}

# Medium deficient number is classified correctly
expect {
	result = classify(32)
	result == Ok(Deficient)
}

# Large deficient number is classified correctly
expect {
	result = classify(33550337)
	result == Ok(Deficient)
}

# Edge case (no factors other than itself) is classified correctly
expect {
	result = classify(1)
	result == Ok(Deficient)
}

##
## Invalid inputs
##

# Zero is rejected (as it is not a positive integer)
expect {
	result = classify(0)
	result.is_err()
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
