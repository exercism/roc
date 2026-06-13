# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color/canonical-data.json
# File last updated on 2026-06-13

import ResistorColor exposing [color_code, colors]

##
## Color codes
##

# Black
expect {
	result = color_code("black")
	result == Ok(0)
}

# White
expect {
	result = color_code("white")
	result == Ok(9)
}

# Orange
expect {
	result = color_code("orange")
	result == Ok(3)
}

##
## Colors
##

expect {
	colors == [
		"black",
		"brown",
		"red",
		"orange",
		"yellow",
		"green",
		"blue",
		"violet",
		"grey",
		"white",
	]
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
