# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/transpose/canonical-data.json
# File last updated on 2026-06-13

import Transpose exposing [transpose]

# empty string
expect {
	input = "".replace_each("□", " ")
	result = transposeinput.replace_each(" ", "□")
	expected = ""
	result == expected
}

# two characters in a row
expect {
	input = "A1".replace_each("□", " ")
	result = transposeinput.replace_each(" ", "□")
	expected = 
		\\A
		\\1

	result == expected
}

# two characters in a column
expect {
	input = 
		\\A
		\\1
			.replace_each(
				"□",
				" ",
			)
	result = transposeinput.replace_each(" ", "□")
	expected = "A1"
	result == expected
}

# simple
expect {
	input = 
		\\ABC
		\\123
			.replace_each(
				"□",
				" ",
			)
	result = transposeinput.replace_each(" ", "□")
	expected = 
		\\A1
		\\B2
		\\C3

	result == expected
}

# single line
expect {
	input = "Single□line.".replace_each("□", " ")
	result = transposeinput.replace_each(" ", "□")
	expected = 
		\\S
		\\i
		\\n
		\\g
		\\l
		\\e
		\\□
		\\l
		\\i
		\\n
		\\e
		\\.

	result == expected
}

# first line longer than second line
expect {
	input = 
		\\The□fourth□line.
		\\The□fifth□line.
			.replace_each(
				"□",
				" ",
			)
	result = transposeinput.replace_each(" ", "□")
	expected = 
		\\TT
		\\hh
		\\ee
		\\□□
		\\ff
		\\oi
		\\uf
		\\rt
		\\th
		\\h□
		\\□l
		\\li
		\\in
		\\ne
		\\e.
		\\.

	result == expected
}

# second line longer than first line
expect {
	input = 
		\\The□first□line.
		\\The□second□line.
			.replace_each(
				"□",
				" ",
			)
	result = transposeinput.replace_each(" ", "□")
	expected = 
		\\TT
		\\hh
		\\ee
		\\□□
		\\fs
		\\ie
		\\rc
		\\so
		\\tn
		\\□d
		\\l□
		\\il
		\\ni
		\\en
		\\.e
		\\□.

	result == expected
}

# mixed line length
expect {
	input = 
		\\The□longest□line.
		\\A□long□line.
		\\A□longer□line.
		\\A□line.
			.replace_each(
				"□",
				" ",
			)
	result = transposeinput.replace_each(" ", "□")
	expected = 
		\\TAAA
		\\h□□□
		\\elll
		\\□ooi
		\\lnnn
		\\ogge
		\\n□e.
		\\glr
		\\ei□
		\\snl
		\\tei
		\\□.n
		\\l□e
		\\i□.
		\\n
		\\e
		\\.

	result == expected
}

# square
expect {
	input = 
		\\HEART
		\\EMBER
		\\ABUSE
		\\RESIN
		\\TREND
			.replace_each(
				"□",
				" ",
			)
	result = transposeinput.replace_each(" ", "□")
	expected = 
		\\HEART
		\\EMBER
		\\ABUSE
		\\RESIN
		\\TREND

	result == expected
}

# rectangle
expect {
	input = 
		\\FRACTURE
		\\OUTLINED
		\\BLOOMING
		\\SEPTETTE
			.replace_each(
				"□",
				" ",
			)
	result = transposeinput.replace_each(" ", "□")
	expected = 
		\\FOBS
		\\RULE
		\\ATOP
		\\CLOT
		\\TIME
		\\UNIT
		\\RENT
		\\EDGE

	result == expected
}

# triangle
expect {
	input = 
		\\T
		\\EE
		\\AAA
		\\SSSS
		\\EEEEE
		\\RRRRRR
			.replace_each(
				"□",
				" ",
			)
	result = transposeinput.replace_each(" ", "□")
	expected = 
		\\TEASER
		\\□EASER
		\\□□ASER
		\\□□□SER
		\\□□□□ER
		\\□□□□□R

	result == expected
}

# jagged triangle
expect {
	input = 
		\\11
		\\2
		\\3333
		\\444
		\\555555
		\\66666
			.replace_each(
				"□",
				" ",
			)
	result = transposeinput.replace_each(" ", "□")
	expected = 
		\\123456
		\\1□3456
		\\□□3456
		\\□□3□56
		\\□□□□56
		\\□□□□5

	result == expected
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
