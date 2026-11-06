# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color-duo/canonical-data.json
# File last updated on 2026-10-27

import ResistorColorDuo exposing [decode_colors]

# Brown and black
expect {
	result = decode_colors(Brown, Black)
	result == 10
}

# Blue and grey
expect {
	result = decode_colors(Blue, Grey)
	result == 68
}

# Yellow and violet
expect {
	result = decode_colors(Yellow, Violet)
	result == 47
}

# White and red
expect {
	result = decode_colors(White, Red)
	result == 92
}

# Orange and orange
expect {
	result = decode_colors(Orange, Orange)
	result == 33
}

# Black and brown, one-digit
expect {
	result = decode_colors(Black, Brown)
	result == 1
}
