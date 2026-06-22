# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/nth-prime/canonical-data.json
# File last updated on 2026-06-22

import NthPrime exposing [prime]

# first prime
expect {
	result = prime(1)
	result == Ok(2)
}

# second prime
expect {
	result = prime(2)
	result == Ok(3)
}

# sixth primes
expect {
	result = prime(6)
	result == Ok(13)
}

# big prime
expect {
	result = prime(10001)
	result == Ok(104743)
}

# there is no zeroth prime
expect {
	result = prime(0)
	result.is_err()
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
