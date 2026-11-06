# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color-trio/canonical-data.json
# File last updated on 2026-10-27

import Resistor exposing [decode_colors]

# Orange and orange and black
expect {
	result = decode_colors(Orange, Orange, Black)
	result == Ohms(33)
}

# Blue and grey and brown
expect {
	result = decode_colors(Blue, Grey, Brown)
	result == Ohms(680)
}

# Red and black and red
expect {
	result = decode_colors(Red, Black, Red)
	result == Kiloohms(2)
}

# Green and brown and orange
expect {
	result = decode_colors(Green, Brown, Orange)
	result == Kiloohms(51)
}

# Yellow and violet and yellow
expect {
	result = decode_colors(Yellow, Violet, Yellow)
	result == Kiloohms(470)
}

# Blue and violet and blue
expect {
	result = decode_colors(Blue, Violet, Blue)
	result == Megaohms(67)
}

# Minimum possible value
expect {
	result = decode_colors(Black, Black, Black)
	result == Ohms(0)
}

# Maximum possible value
expect {
	result = decode_colors(White, White, White)
	result == Gigaohms(99)
}

# First two colors make an invalid octal number
expect {
	result = decode_colors(Black, Grey, Black)
	result == Ohms(8)
}

# Ignore extra colors
expect {
	result = decode_colors(Blue, Green, Yellow)
	result == Kiloohms(650)
}
