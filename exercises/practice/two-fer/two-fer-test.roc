# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/two-fer/canonical-data.json
# File last updated on 2026-06-22

import TwoFer exposing [two_fer]

# no name given
expect {
	result = two_fer(Anonymous)
	result == "One for you, one for me."
}

# a name given
expect {
	result = two_fer((Name("Alice")))
	result == "One for Alice, one for me."
}

# another name given
expect {
	result = two_fer((Name("Bob")))
	result == "One for Bob, one for me."
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
