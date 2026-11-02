Deque :: {
	# TODO: change this opaque type however you need
}.{

	empty : () -> Deque
	empty = || {
		crash "Please implement the 'empty' function"
	}

	append : Deque, U64 -> Deque
	append = |deque, value| {
		crash "Please implement the 'append' function"
	}

	pop_last : Deque -> Try({ deque : Deque, value : U64 }, [DequeWasEmpty])
	pop_last = |deque| {
		crash "Please implement the 'pop_last' function"
	}

	prepend : Deque, U64 -> Deque
	prepend = |deque, value| {
		crash "Please implement the 'prepend' function"
	}

	pop_first : Deque -> Try({ deque : Deque, value : U64 }, [DequeWasEmpty])
	pop_first = |deque| {
		crash "Please implement the 'pop_first' function"
	}

	remove_value : Deque, U64 -> Deque
	remove_value = |deque, value| {
		crash "Please implement the 'remove_value' function"
	}

	len : Deque -> U64
	len = |deque| {
		crash "Please implement the 'len' function"
	}
}
