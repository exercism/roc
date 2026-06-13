# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/isbn-verifier/canonical-data.json
# File last updated on 2026-06-13

import IsbnVerifier exposing [is_valid]

# valid isbn
expect {
	result = is_valid("3-598-21508-8")
	result == Bool.True
}

# invalid isbn check digit
expect {
	result = is_valid("3-598-21508-9")
	result == Bool.False
}

# valid isbn with a check digit of 10
expect {
	result = is_valid("3-598-21507-X")
	result == Bool.True
}

# check digit is a character other than X
expect {
	result = is_valid("3-598-21507-A")
	result == Bool.False
}

# invalid check digit in isbn is not treated as zero
expect {
	result = is_valid("4-598-21507-B")
	result == Bool.False
}

# invalid character in isbn is not treated as zero
expect {
	result = is_valid("3-598-P1581-X")
	result == Bool.False
}

# X is only valid as a check digit
expect {
	result = is_valid("3-598-2X507-9")
	result == Bool.False
}

# valid isbn without separating dashes
expect {
	result = is_valid("3598215088")
	result == Bool.True
}

# isbn without separating dashes and X as check digit
expect {
	result = is_valid("359821507X")
	result == Bool.True
}

# isbn without check digit and dashes
expect {
	result = is_valid("359821507")
	result == Bool.False
}

# too long isbn and no dashes
expect {
	result = is_valid("3598215078X")
	result == Bool.False
}

# too short isbn
expect {
	result = is_valid("00")
	result == Bool.False
}

# isbn without check digit
expect {
	result = is_valid("3-598-21507")
	result == Bool.False
}

# check digit of X should not be used for 0
expect {
	result = is_valid("3-598-21515-X")
	result == Bool.False
}

# empty isbn
expect {
	result = is_valid("")
	result == Bool.False
}

# input is 9 characters
expect {
	result = is_valid("134456729")
	result == Bool.False
}

# invalid characters are not ignored after checking length
expect {
	result = is_valid("3132P34035")
	result == Bool.False
}

# invalid characters are not ignored before checking length
expect {
	result = is_valid("3598P215088")
	result == Bool.False
}

# input is too long but contains a valid isbn
expect {
	result = is_valid("98245726788")
	result == Bool.False
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
