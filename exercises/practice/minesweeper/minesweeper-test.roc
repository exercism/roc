# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/minesweeper/canonical-data.json
# File last updated on 2026-06-13

import Minesweeper exposing [annotate]

# no rows
expect {
	minefield = "".replace_each("·", " ")
	result = annotate(minefield)
	expected = "".replace_each("·", " ")
	result == expected
}

# no columns
expect {
	minefield = "".replace_each("·", " ")
	result = annotate(minefield)
	expected = "".replace_each("·", " ")
	result == expected
}

# no mines
expect {
	minefield = 
		\\···
		\\···
		\\···
			.replace_each(
				"·",
				" ",
			)
	result = annotate(minefield)
	expected = 
		\\···
		\\···
		\\···
			.replace_each(
				"·",
				" ",
			)
	result == expected
}

# minefield with only mines
expect {
	minefield = 
		\\***
		\\***
		\\***
			.replace_each(
				"·",
				" ",
			)
	result = annotate(minefield)
	expected = 
		\\***
		\\***
		\\***
			.replace_each(
				"·",
				" ",
			)
	result == expected
}

# mine surrounded by spaces
expect {
	minefield = 
		\\···
		\\·*·
		\\···
			.replace_each(
				"·",
				" ",
			)
	result = annotate(minefield)
	expected = 
		\\111
		\\1*1
		\\111
			.replace_each(
				"·",
				" ",
			)
	result == expected
}

# space surrounded by mines
expect {
	minefield = 
		\\***
		\\*·*
		\\***
			.replace_each(
				"·",
				" ",
			)
	result = annotate(minefield)
	expected = 
		\\***
		\\*8*
		\\***
			.replace_each(
				"·",
				" ",
			)
	result == expected
}

# horizontal line
expect {
	minefield = "·*·*·".replace_each("·", " ")
	result = annotate(minefield)
	expected = "1*2*1".replace_each("·", " ")
	result == expected
}

# horizontal line, mines at edges
expect {
	minefield = "*···*".replace_each("·", " ")
	result = annotate(minefield)
	expected = "*1·1*".replace_each("·", " ")
	result == expected
}

# vertical line
expect {
	minefield = 
		\\·
		\\*
		\\·
		\\*
		\\·
			.replace_each(
				"·",
				" ",
			)
	result = annotate(minefield)
	expected = 
		\\1
		\\*
		\\2
		\\*
		\\1
			.replace_each(
				"·",
				" ",
			)
	result == expected
}

# vertical line, mines at edges
expect {
	minefield = 
		\\*
		\\·
		\\·
		\\·
		\\*
			.replace_each(
				"·",
				" ",
			)
	result = annotate(minefield)
	expected = 
		\\*
		\\1
		\\·
		\\1
		\\*
			.replace_each(
				"·",
				" ",
			)
	result == expected
}

# cross
expect {
	minefield = 
		\\··*··
		\\··*··
		\\*****
		\\··*··
		\\··*··
			.replace_each(
				"·",
				" ",
			)
	result = annotate(minefield)
	expected = 
		\\·2*2·
		\\25*52
		\\*****
		\\25*52
		\\·2*2·
			.replace_each(
				"·",
				" ",
			)
	result == expected
}

# large minefield
expect {
	minefield = 
		\\·*··*·
		\\··*···
		\\····*·
		\\···*·*
		\\·*··*·
		\\······
			.replace_each(
				"·",
				" ",
			)
	result = annotate(minefield)
	expected = 
		\\1*22*1
		\\12*322
		\\·123*2
		\\112*4*
		\\1*22*2
		\\111111
			.replace_each(
				"·",
				" ",
			)
	result == expected
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
