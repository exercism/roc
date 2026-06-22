# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/matching-brackets/canonical-data.json
# File last updated on 2026-06-22

import MatchingBrackets exposing [is_paired]

# paired square brackets
expect {
	result = "[]"->is_paired()
	result == Bool.True
}

# empty string
expect {
	result = ""->is_paired()
	result == Bool.True
}

# unpaired brackets
expect {
	result = "[["->is_paired()
	result == Bool.False
}

# wrong ordered brackets
expect {
	result = "}{"->is_paired()
	result == Bool.False
}

# wrong closing bracket
expect {
	result = "{]"->is_paired()
	result == Bool.False
}

# paired with whitespace
expect {
	result = "{ }"->is_paired()
	result == Bool.True
}

# partially paired brackets
expect {
	result = "{[])"->is_paired()
	result == Bool.False
}

# simple nested brackets
expect {
	result = "{[]}"->is_paired()
	result == Bool.True
}

# several paired brackets
expect {
	result = "{}[]"->is_paired()
	result == Bool.True
}

# paired and nested brackets
expect {
	result = "([{}({}[])])"->is_paired()
	result == Bool.True
}

# unopened closing brackets
expect {
	result = "{[)][]}"->is_paired()
	result == Bool.False
}

# unpaired and nested brackets
expect {
	result = "([{])"->is_paired()
	result == Bool.False
}

# paired and wrong nested brackets
expect {
	result = "[({]})"->is_paired()
	result == Bool.False
}

# paired and wrong nested brackets but innermost are correct
expect {
	result = "[({}])"->is_paired()
	result == Bool.False
}

# paired and incomplete brackets
expect {
	result = "{}["->is_paired()
	result == Bool.False
}

# too many closing brackets
expect {
	result = "[]]"->is_paired()
	result == Bool.False
}

# early unexpected brackets
expect {
	result = ")()"->is_paired()
	result == Bool.False
}

# early mismatched brackets
expect {
	result = "{)()"->is_paired()
	result == Bool.False
}

# math expression
expect {
	result = "(((185 + 223.85) * 15) - 543)/2"->is_paired()
	result == Bool.True
}

# complex latex expression
expect {
	result = "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)"->is_paired()
	result == Bool.True
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
