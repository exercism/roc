Zipper :: {
	# TODO: change this opaque type however you need
	todo1 : U64,
	todo2 : U64,
	todo3 : U64,
	# etc.
}.{

	Tree := { value : U64, left ?: Tree, right ?: Tree }.{
		# The following line enables the default `is_eq` implementation
		is_eq : _

		to_zipper : Tree -> Zipper
		to_zipper = |tree| {
			crash "Please implement the 'to_zipper' function"
		}
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _

	to_tree : Zipper -> Tree
	to_tree = |zipper| {
		crash "Please implement the 'to_tree' function"
	}

	value : Zipper -> U64
	value = |zipper| {
		crash "Please implement the 'value' function"
	}

	left : Zipper -> Try(Zipper, _)
	left = |zipper| {
		crash "Please implement the 'left' function"
	}

	right : Zipper -> Try(Zipper, _)
	right = |zipper| {
		crash "Please implement the 'right' function"
	}

	up : Zipper -> Try(Zipper, _)
	up = |zipper| {
		crash "Please implement the 'up' function"
	}

	set_value : Zipper, U64 -> Zipper
	set_value = |zipper, new_value| {
		crash "Please implement the 'set_value' function"
	}

	set_left : Zipper, Tree -> Zipper
	set_left = |zipper, tree| {
		crash "Please implement the 'set_left' function"
	}

	set_right : Zipper, Tree -> Zipper
	set_right = |zipper, tree| {
		crash "Please implement the 'set_right' function"
	}

	remove_left : Zipper -> Zipper
	remove_left = |zipper| {
		crash "Please implement the 'remove_left' function"
	}

	remove_right : Zipper -> Zipper
	remove_right = |zipper| {
		crash "Please implement the 'remove_right' function"
	}
}
