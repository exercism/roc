# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color-trio/canonical-data.json
# File last updated on 2026-08-18

import ResistorColorTrio exposing [label]

# Orange and orange and black
expect {
	result = label(Orange, Orange, Black)
	result == Ohms(33)
}

# Blue and grey and brown
expect {
	result = label(Blue, Grey, Brown)
	result == Ohms(680)
}

# Red and black and red
expect {
	result = label(Red, Black, Red)
	result == Kiloohms(2)
}

# Green and brown and orange
expect {
	result = label(Green, Brown, Orange)
	result == Kiloohms(51)
}

# Yellow and violet and yellow
expect {
	result = label(Yellow, Violet, Yellow)
	result == Kiloohms(470)
}

# Blue and violet and blue
expect {
	result = label(Blue, Violet, Blue)
	result == Megaohms(67)
}

# Minimum possible value
expect {
	result = label(Black, Black, Black)
	result == Ohms(0)
}

# Maximum possible value
expect {
	result = label(White, White, White)
	result == Gigaohms(99)
}

# First two colors make an invalid octal number
expect {
	result = label(Black, Grey, Black)
	result == Ohms(8)
}

# Ignore extra colors
expect {
	result = label(Blue, Green, Yellow)
	result == Kiloohms(650)
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
