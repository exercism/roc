# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/acronym/canonical-data.json
# File last updated on 2026-06-09
app [main!] {
	pf: platform "https://github.com/lukewilliamboswell/roc-platform-template-zig/releases/download/0.7/DuRUyJh31Gt41YArMcVcvybLa2bCWboccWQ7Zq1KZPZ6.tar.zst",
}

import pf.Stdout

main! = |_args| {
	Ok({})
}

import Acronym

# basic
expect {
	result = Acronym.abbreviate("Portable Network Graphics")
	result == "PNG"
}

# lowercase words
expect {
	result = Acronym.abbreviate("Ruby on Rails")
	result == "ROR"
}

# punctuation
expect {
	result = Acronym.abbreviate("First In, First Out")
	result == "FIFO"
}

# all caps word
expect {
	result = Acronym.abbreviate("GNU Image Manipulation Program")
	result == "GIMP"
}

# punctuation without whitespace
expect {
	result = Acronym.abbreviate("Complementary metal-oxide semiconductor")
	result == "CMOS"
}

# very long abbreviation
expect {
	result = Acronym.abbreviate("Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me")
	result == "ROTFLSHTMDCOALM"
}

# consecutive delimiters
expect {
	result = Acronym.abbreviate("Something - I made up from thin air")
	result == "SIMUFTA"
}

# apostrophes
expect {
	result = Acronym.abbreviate("Halley's Comet")
	result == "HC"
}

# underscore emphasis
expect {
	result = Acronym.abbreviate("The Road _Not_ Taken")
	result == "TRNT"
}
