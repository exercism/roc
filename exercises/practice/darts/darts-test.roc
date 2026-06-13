# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/darts/canonical-data.json
# File last updated on 2026-06-13

import Darts exposing [score]

# Missed target
expect {
	result = score(-9.0.F64, 9.0.F64)
	result == 0
}

# On the outer circle
expect {
	result = score(0.0.F64, 10.0.F64)
	result == 1
}

# On the middle circle
expect {
	result = score(-5.0.F64, 0.0.F64)
	result == 5
}

# On the inner circle
expect {
	result = score(0.0.F64, -1.0.F64)
	result == 10
}

# Exactly on center
expect {
	result = score(0.0.F64, 0.0.F64)
	result == 10
}

# Near the center
expect {
	result = score(-0.1.F64, -0.1.F64)
	result == 10
}

# Just within the inner circle
expect {
	result = score(0.7.F64, 0.7.F64)
	result == 10
}

# Just outside the inner circle
expect {
	result = score(0.8.F64, -0.8.F64)
	result == 5
}

# Just within the middle circle
expect {
	result = score(-3.5.F64, 3.5.F64)
	result == 5
}

# Just outside the middle circle
expect {
	result = score(-3.6.F64, -3.6.F64)
	result == 1
}

# Just within the outer circle
expect {
	result = score(-7.0.F64, 7.0.F64)
	result == 1
}

# Just outside the outer circle
expect {
	result = score(7.1.F64, -7.1.F64)
	result == 0
}

# Asymmetric position between the inner and middle circles
expect {
	result = score(0.5.F64, -4.0.F64)
	result == 5
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
