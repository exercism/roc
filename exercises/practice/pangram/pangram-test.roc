# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pangram/canonical-data.json
# File last updated on 2026-06-22

import Pangram exposing [is_pangram]

# empty sentence
expect {
	result = is_pangram("")
	result == Bool.False
}

# perfect lower case
expect {
	result = is_pangram("abcdefghijklmnopqrstuvwxyz")
	result == Bool.True
}

# only lower case
expect {
	result = is_pangram("the quick brown fox jumps over the lazy dog")
	result == Bool.True
}

# missing the letter 'x'
expect {
	result = is_pangram("a quick movement of the enemy will jeopardize five gunboats")
	result == Bool.False
}

# missing the letter 'h'
expect {
	result = is_pangram("five boxing wizards jump quickly at it")
	result == Bool.False
}

# with underscores
expect {
	result = is_pangram("the_quick_brown_fox_jumps_over_the_lazy_dog")
	result == Bool.True
}

# with numbers
expect {
	result = is_pangram("the 1 quick brown fox jumps over the 2 lazy dogs")
	result == Bool.True
}

# missing letters replaced by numbers
expect {
	result = is_pangram("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog")
	result == Bool.False
}

# mixed case and punctuation
expect {
	result = is_pangram("\"Five quacking Zephyrs jolt my wax bed.\"")
	result == Bool.True
}

# a-m and A-M are 26 different characters but not a pangram
expect {
	result = is_pangram("abcdefghijklm ABCDEFGHIJKLM")
	result == Bool.False
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
