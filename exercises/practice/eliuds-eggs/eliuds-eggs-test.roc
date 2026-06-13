# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/eliuds-eggs/canonical-data.json
# File last updated on 2026-06-13

import EliudsEggs exposing [egg_count]

# 0 eggs
expect {
	result = egg_count(0)
	result == 0
}

# 1 egg
expect {
	result = egg_count(16)
	result == 1
}

# 4 eggs
expect {
	result = egg_count(89)
	result == 4
}

# 13 eggs
expect {
	result = egg_count(2000000000)
	result == 13
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
