# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/line-up/canonical-data.json
# File last updated on 2026-08-18

import LineUp exposing [format]

# format smallest non-exceptional ordinal numeral 4
expect {
	result = format("Gianna", 4)
	result == "Gianna, you are the 4th customer we serve today. Thank you!"
}
# format greatest single digit non-exceptional ordinal numeral 9
expect {
	result = format("Maarten", 9)
	result == "Maarten, you are the 9th customer we serve today. Thank you!"
}
# format non-exceptional ordinal numeral 5
expect {
	result = format("Petronila", 5)
	result == "Petronila, you are the 5th customer we serve today. Thank you!"
}
# format non-exceptional ordinal numeral 6
expect {
	result = format("Attakullakulla", 6)
	result == "Attakullakulla, you are the 6th customer we serve today. Thank you!"
}
# format non-exceptional ordinal numeral 7
expect {
	result = format("Kate", 7)
	result == "Kate, you are the 7th customer we serve today. Thank you!"
}
# format non-exceptional ordinal numeral 8
expect {
	result = format("Maximiliano", 8)
	result == "Maximiliano, you are the 8th customer we serve today. Thank you!"
}
# format exceptional ordinal numeral 1
expect {
	result = format("Mary", 1)
	result == "Mary, you are the 1st customer we serve today. Thank you!"
}
# format exceptional ordinal numeral 2
expect {
	result = format("Haruto", 2)
	result == "Haruto, you are the 2nd customer we serve today. Thank you!"
}
# format exceptional ordinal numeral 3
expect {
	result = format("Henriette", 3)
	result == "Henriette, you are the 3rd customer we serve today. Thank you!"
}
# format smallest two digit non-exceptional ordinal numeral 10
expect {
	result = format("Alvarez", 10)
	result == "Alvarez, you are the 10th customer we serve today. Thank you!"
}
# format non-exceptional ordinal numeral 11
expect {
	result = format("Jacqueline", 11)
	result == "Jacqueline, you are the 11th customer we serve today. Thank you!"
}
# format non-exceptional ordinal numeral 12
expect {
	result = format("Juan", 12)
	result == "Juan, you are the 12th customer we serve today. Thank you!"
}
# format non-exceptional ordinal numeral 13
expect {
	result = format("Patricia", 13)
	result == "Patricia, you are the 13th customer we serve today. Thank you!"
}
# format exceptional ordinal numeral 21
expect {
	result = format("Washi", 21)
	result == "Washi, you are the 21st customer we serve today. Thank you!"
}
# format exceptional ordinal numeral 22 ending in nd even though it is a multiple of 11
expect {
	result = format("Ingrid", 22)
	result == "Ingrid, you are the 22nd customer we serve today. Thank you!"
}
# format exceptional ordinal numeral 33 ending in rd even though it is a multiple of 11
expect {
	result = format("Mario", 33)
	result == "Mario, you are the 33rd customer we serve today. Thank you!"
}
# format exceptional ordinal numeral 52 ending in nd even though it is a multiple of 13
expect {
	result = format("Quentin", 52)
	result == "Quentin, you are the 52nd customer we serve today. Thank you!"
}
# format exceptional ordinal numeral 62
expect {
	result = format("Nayra", 62)
	result == "Nayra, you are the 62nd customer we serve today. Thank you!"
}
# format non-exceptional ordinal numeral 72 ending in nd even though it is a multiple of 12
expect {
	result = format("Ugo", 72)
	result == "Ugo, you are the 72nd customer we serve today. Thank you!"
}
# format exceptional ordinal numeral 91 ending in st even though it is a multiple of 13
expect {
	result = format("Boris", 91)
	result == "Boris, you are the 91st customer we serve today. Thank you!"
}
# format exceptional ordinal numeral 100
expect {
	result = format("John", 100)
	result == "John, you are the 100th customer we serve today. Thank you!"
}
# format exceptional ordinal numeral 101
expect {
	result = format("Zeinab", 101)
	result == "Zeinab, you are the 101st customer we serve today. Thank you!"
}
# format non-exceptional ordinal numeral 112
expect {
	result = format("Knud", 112)
	result == "Knud, you are the 112th customer we serve today. Thank you!"
}
# format exceptional ordinal numeral 123
expect {
	result = format("Yma", 123)
	result == "Yma, you are the 123rd customer we serve today. Thank you!"
}
# format large number 972 ending in nd even though it is a multiple of 12
expect {
	result = format("Elias", 972)
	result == "Elias, you are the 972nd customer we serve today. Thank you!"
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
