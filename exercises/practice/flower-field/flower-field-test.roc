# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/flower-field/canonical-data.json
# File last updated on 2026-06-13

import FlowerField exposing [annotate]

# no rows
expect {
	garden = "".replace_each("·", " ")
	result = annotate(garden)
	expected = "".replace_each("·", " ")
	result == expected
}

# no columns
expect {
	garden = "".replace_each("·", " ")
	result = annotate(garden)
	expected = "".replace_each("·", " ")
	result == expected
}

# no flowers
expect {
	garden = 
		\\···
		\\···
		\\···
			.replace_each(
				"·",
				" ",
			)
	result = annotate(garden)
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

# garden full of flowers
expect {
	garden = 
		\\***
		\\***
		\\***
			.replace_each(
				"·",
				" ",
			)
	result = annotate(garden)
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

# flower surrounded by spaces
expect {
	garden = 
		\\···
		\\·*·
		\\···
			.replace_each(
				"·",
				" ",
			)
	result = annotate(garden)
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

# space surrounded by flowers
expect {
	garden = 
		\\***
		\\*·*
		\\***
			.replace_each(
				"·",
				" ",
			)
	result = annotate(garden)
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
	garden = "·*·*·".replace_each("·", " ")
	result = annotate(garden)
	expected = "1*2*1".replace_each("·", " ")
	result == expected
}

# horizontal line, flowers at edges
expect {
	garden = "*···*".replace_each("·", " ")
	result = annotate(garden)
	expected = "*1·1*".replace_each("·", " ")
	result == expected
}

# vertical line
expect {
	garden = 
		\\·
		\\*
		\\·
		\\*
		\\·
			.replace_each(
				"·",
				" ",
			)
	result = annotate(garden)
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

# vertical line, flowers at edges
expect {
	garden = 
		\\*
		\\·
		\\·
		\\·
		\\*
			.replace_each(
				"·",
				" ",
			)
	result = annotate(garden)
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
	garden = 
		\\··*··
		\\··*··
		\\*****
		\\··*··
		\\··*··
			.replace_each(
				"·",
				" ",
			)
	result = annotate(garden)
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

# large garden
expect {
	garden = 
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
	result = annotate(garden)
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
