# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/flower-field/canonical-data.json
# File last updated on 2026-06-20

import FlowerField exposing [annotate]

# no rows
expect {
	garden = ""
	result = annotate(garden)
	expected = ""
	result == expected
}

# no columns
expect {
	garden = ""
	result = annotate(garden)
	expected = ""
	result == expected
}

# no flowers
expect {
	garden = 
		\\   
		\\   
		\\   

	result = annotate(garden)
	expected = 
		\\   
		\\   
		\\   

	result == expected
}

# garden full of flowers
expect {
	garden = 
		\\***
		\\***
		\\***

	result = annotate(garden)
	expected = 
		\\***
		\\***
		\\***

	result == expected
}

# flower surrounded by spaces
expect {
	garden = 
		\\   
		\\ * 
		\\   

	result = annotate(garden)
	expected = 
		\\111
		\\1*1
		\\111

	result == expected
}

# space surrounded by flowers
expect {
	garden = 
		\\***
		\\* *
		\\***

	result = annotate(garden)
	expected = 
		\\***
		\\*8*
		\\***

	result == expected
}

# horizontal line
expect {
	garden = " * * "
	result = annotate(garden)
	expected = "1*2*1"
	result == expected
}

# horizontal line, flowers at edges
expect {
	garden = "*   *"
	result = annotate(garden)
	expected = "*1 1*"
	result == expected
}

# vertical line
expect {
	garden = 
		\\ 
		\\*
		\\ 
		\\*
		\\ 

	result = annotate(garden)
	expected = 
		\\1
		\\*
		\\2
		\\*
		\\1

	result == expected
}

# vertical line, flowers at edges
expect {
	garden = 
		\\*
		\\ 
		\\ 
		\\ 
		\\*

	result = annotate(garden)
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
	garden = 
		\\  *  
		\\  *  
		\\*****
		\\  *  
		\\  *  

	result = annotate(garden)
	expected = 
		\\ 2*2 
		\\25*52
		\\*****
		\\25*52
		\\ 2*2 

	result == expected
}

# large garden
expect {
	garden = 
		\\ *  * 
		\\  *   
		\\    * 
		\\   * *
		\\ *  * 
		\\      

	result = annotate(garden)
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
