# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/collatz-conjecture/canonical-data.json
# File last updated on 2026-06-13

import CollatzConjecture exposing [steps]

# zero steps for one
expect {
	result = steps(1)
	result == Ok(0)
}

# divide if even
expect {
	result = steps(16)
	result == Ok(4)
}

# even and odd steps
expect {
	result = steps(12)
	result == Ok(9)
}

# large number of even and odd steps
expect {
	result = steps(1000000)
	result == Ok(152)
}

# zero is an error
expect {
	result = steps(0)
	result.is_err()
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
