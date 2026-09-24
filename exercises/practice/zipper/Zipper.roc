## A Zipper lets the user traverse and update a tree
Zipper :: {
	# TODO: change this opaque type however you need
	todo1 : U64,
	todo2 : U64,
	todo3 : U64,
	# etc.
}.{
	## A binary tree structure where each node holds an integer
	Tree := { value : U64, left ?: Tree, right ?: Tree }.{
		# The following line enables the default `is_eq` implementation
		is_eq : _

		## get a zipper out of a tree, the focus is on the root node
		to_zipper : Tree -> Zipper
		to_zipper = |tree| {
			crash "Please implement the 'to_zipper' function"
		}
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _

	## get the tree out of the zipper
	to_tree : Zipper -> Tree
	to_tree = |zipper| {
		crash "Please implement the 'to_tree' function"
	}

	## get the value of the focus node
	value : Zipper -> U64
	value = |zipper| {
		crash "Please implement the 'value' function"
	}

	## move the focus to the current focus's left child, returns a new zipper
	left : Zipper -> Try(Zipper, _)
	left = |zipper| {
		crash "Please implement the 'left' function"
	}

	## move the focus to the current focus's right child, returns a new zipper
	right : Zipper -> Try(Zipper, _)
	right = |zipper| {
		crash "Please implement the 'right' function"
	}

	## move the focus to the parent, returns a new zipper
	up : Zipper -> Try(Zipper, _)
	up = |zipper| {
		crash "Please implement the 'up' function"
	}

	## set the value of the focus node, returns a new zipper
	set_value : Zipper, U64 -> Zipper
	set_value = |zipper, new_value| {
		crash "Please implement the 'set_value' function"
	}

	## replace the left child, returns a new zipper
	set_left : Zipper, Tree -> Zipper
	set_left = |zipper, tree| {
		crash "Please implement the 'set_left' function"
	}

	## replace the right child, returns a new zipper
	set_right : Zipper, Tree -> Zipper
	set_right = |zipper, tree| {
		crash "Please implement the 'set_right' function"
	}

	## remove the left child, returns a new zipper
	remove_left : Zipper -> Zipper
	remove_left = |zipper| {
		crash "Please implement the 'remove_left' function"
	}

	## remove the right child, returns a new zipper
	remove_right : Zipper -> Zipper
	remove_right = |zipper| {
		crash "Please implement the 'remove_right' function"
	}
}
