# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/minesweeper/canonical-data.json
# File last updated on 2026-06-20

import Minesweeper exposing [annotate]

# no rows
expect {
	minefield = ""
	result = annotate(minefield)
	expected = ""
	result == expected
}

# no columns
expect {
	minefield = ""
	result = annotate(minefield)
	expected = ""
	result == expected
}

# no mines
expect {
	minefield = 
		\\   
		\\   
		\\   

	result = annotate(minefield)
	expected = 
		\\   
		\\   
		\\   

	result == expected
}

# minefield with only mines
expect {
	minefield = 
		\\***
		\\***
		\\***

	result = annotate(minefield)
	expected = 
		\\***
		\\***
		\\***

	result == expected
}

# mine surrounded by spaces
expect {
	minefield = 
		\\   
		\\ * 
		\\   

	result = annotate(minefield)
	expected = 
		\\111
		\\1*1
		\\111

	result == expected
}

# space surrounded by mines
expect {
	minefield = 
		\\***
		\\* *
		\\***

	result = annotate(minefield)
	expected = 
		\\***
		\\*8*
		\\***

	result == expected
}

# horizontal line
expect {
	minefield = " * * "
	result = annotate(minefield)
	expected = "1*2*1"
	result == expected
}

# horizontal line, mines at edges
expect {
	minefield = "*   *"
	result = annotate(minefield)
	expected = "*1 1*"
	result == expected
}

# vertical line
expect {
	minefield = 
		\\ 
		\\*
		\\ 
		\\*
		\\ 

	result = annotate(minefield)
	expected = 
		\\1
		\\*
		\\2
		\\*
		\\1

	result == expected
}

# vertical line, mines at edges
expect {
	minefield = 
		\\*
		\\ 
		\\ 
		\\ 
		\\*

	result = annotate(minefield)
	expected = 
		\\*
		\\1
		\\ 
		\\1
		\\*

	result == expected
}

# cross
expect {
	minefield = 
		\\  *  
		\\  *  
		\\*****
		\\  *  
		\\  *  

	result = annotate(minefield)
	expected = 
		\\ 2*2 
		\\25*52
		\\*****
		\\25*52
		\\ 2*2 

	result == expected
}

# large minefield
expect {
	minefield = 
		\\ *  * 
		\\  *   
		\\    * 
		\\   * *
		\\ *  * 
		\\      

	result = annotate(minefield)
	expected = 
		\\1*22*1
		\\12*322
		\\ 123*2
		\\112*4*
		\\1*22*2
		\\111111

	result == expected
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
