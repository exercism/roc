Deque :: {
	# TODO: change this opaque type however you need
}.{

	## Create an empty deque
	empty : () -> Deque
	empty = || {
		crash "Please implement the 'empty' function"
	}

	## Add a value at the end of the deque
    ## This function is often named `push` in other languages
	append : Deque, U64 -> Deque
	append = |deque, value| {
		crash "Please implement the 'append' function"
	}

	## Remove the last value and return it with the updated deque, or Err(DequeWasEmpty)
    ## This function is often named `pop` in other languages
	pop_last : Deque -> Try({ deque : Deque, value : U64 }, [DequeWasEmpty, ..])
	pop_last = |deque| {
		crash "Please implement the 'pop_last' function"
	}

	## Add a value at the start of the deque
    ## This function is often named `unshift` in other languages
	prepend : Deque, U64 -> Deque
	prepend = |deque, value| {
		crash "Please implement the 'prepend' function"
	}

	## Remove the first value and return it with the updated deque, or Err(DequeWasEmpty)
    ## This function is often named `shift` in other languages
	pop_first : Deque -> Try({ deque : Deque, value : U64 }, [DequeWasEmpty, ..])
	pop_first = |deque| {
		crash "Please implement the 'pop_first' function"
	}

	## Remove the first occurrence of a value, leaving the deque unchanged if absent
	remove_value : Deque, U64 -> Deque
	remove_value = |deque, value| {
		crash "Please implement the 'remove_value' function"
	}

	## Return the number of values in the deque
	len : Deque -> U64
	len = |deque| {
		crash "Please implement the 'len' function"
	}
}
