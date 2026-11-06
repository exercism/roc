# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color/canonical-data.json
# File last updated on 2026-10-27

import ResistorColor exposing [color_code, colors]

##
## Color codes
##

# Black
expect {
	result = color_code(Black)
	result == 0
}

# White
expect {
	result = color_code(White)
	result == 9
}

# Orange
expect {
	result = color_code(Orange)
	result == 3
}

##
## Colors
##

expect {
	colors == [
		Black,
		Brown,
		Red,
		Orange,
		Yellow,
		Green,
		Blue,
		Violet,
		Grey,
		White,
	]
}
