# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/isogram/canonical-data.json
# File last updated on 2026-06-22

import Isogram exposing [is_isogram]

# empty string
expect {
	result = is_isogram("")
	result == Bool.True
}

# isogram with only lower case characters
expect {
	result = is_isogram("isogram")
	result == Bool.True
}

# word with one duplicated character
expect {
	result = is_isogram("eleven")
	result == Bool.False
}

# word with one duplicated character from the end of the alphabet
expect {
	result = is_isogram("zzyzx")
	result == Bool.False
}

# longest reported english isogram
expect {
	result = is_isogram("subdermatoglyphic")
	result == Bool.True
}

# word with duplicated character in mixed case
expect {
	result = is_isogram("Alphabet")
	result == Bool.False
}

# word with duplicated character in mixed case, lowercase first
expect {
	result = is_isogram("alphAbet")
	result == Bool.False
}

# hypothetical isogrammic word with hyphen
expect {
	result = is_isogram("thumbscrew-japingly")
	result == Bool.True
}

# hypothetical word with duplicated character following hyphen
expect {
	result = is_isogram("thumbscrew-jappingly")
	result == Bool.False
}

# isogram with duplicated hyphen
expect {
	result = is_isogram("six-year-old")
	result == Bool.True
}

# made-up name that is an isogram
expect {
	result = is_isogram("Emily Jung Schwartzkopf")
	result == Bool.True
}

# duplicated character in the middle
expect {
	result = is_isogram("accentor")
	result == Bool.False
}

# same first and last characters
expect {
	result = is_isogram("angola")
	result == Bool.False
}

# word with duplicated character and with two hyphens
expect {
	result = is_isogram("up-to-date")
	result == Bool.False
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
