##
## Example solution
##

## A Zipper lets the user traverse and update a tree
Zipper :: {
	focus : Tree,
	crumbs : List(Zipper.Crumb),
}.{

	## A binary tree structure where each node holds an integer
	Tree := { value : U64, left ?: Tree, right ?: Tree }.{
		# The following line enables the default `is_eq` implementation
		is_eq : _

		## get a zipper out of a tree, the focus is on the root node
		to_zipper : Tree -> Zipper
		to_zipper = |tree| {
			{ focus: tree, crumbs: [] }
		}
	}

	## A Crumb stores the parent's value and the unvisited sibling subtree
	Crumb : [Left(Tree), Right(Tree)]

	# The following line enables the default `is_eq` implementation
	is_eq : _

	## get the tree out of the zipper
	to_tree : Zipper -> Tree
	to_tree = |zipper| {
		match zipper.up() {
			Ok(upper_zipper) => upper_zipper.to_tree()
			Err(FocusWasOnRoot) => zipper.focus
		}
	}

	## get the value of the focus node
	value : Zipper -> U64
	value = |zipper| {
		zipper.focus.value
	}

	## move the focus to the current focus's left child, returns a new zipper
	left : Zipper -> Try(Zipper, [ChildDidNotExist])
	left = |zipper| {
		left_child = zipper.focus.?left ? |MissingField| ChildDidNotExist
		crumbs = zipper.crumbs.append(Left({ ..zipper.focus, left: _ }))
		Ok({ focus: left_child, crumbs })
	}

	## move the focus to the current focus's right child, returns a new zipper
	right : Zipper -> Try(Zipper, [ChildDidNotExist])
	right = |zipper| {
		right_child = zipper.focus.?right ? |MissingField| ChildDidNotExist
		crumbs = zipper.crumbs.append(Right({ ..zipper.focus, right: _ }))
		Ok({ focus: right_child, crumbs })
	}

	## move the focus to the parent, returns a new zipper
	up : Zipper -> Try(Zipper, [FocusWasOnRoot])
	up = |zipper| {
		match zipper.crumbs {
			[] => Err(FocusWasOnRoot)
			[.. as rest, last] => {
				focus : Tree
				focus = match last {
					Left(parent) => { ..parent, left: zipper.focus }
					Right(parent) => { ..parent, right: zipper.focus }
				}
				Ok({ focus, crumbs: rest })
			}
		}
	}

	## set the value of the focus node, returns a new zipper
	set_value : Zipper, U64 -> Zipper
	set_value = |zipper, new_value| {
		focus = { ..zipper.focus, value: new_value }
		{ ..zipper, focus }
	}

	## replace the left child, returns a new zipper
	set_left : Zipper, Tree -> Zipper
	set_left = |zipper, tree| {
		focus = { ..zipper.focus, left: tree }
		{ ..zipper, focus }
	}

	## replace the right child, returns a new zipper
	set_right : Zipper, Tree -> Zipper
	set_right = |zipper, tree| {
		focus = { ..zipper.focus, right: tree }
		{ ..zipper, focus }
	}

	## remove the left child, returns a new zipper
	remove_left : Zipper -> Zipper
	remove_left = |zipper| {
		focus = { ..zipper.focus, left: _ }
		{ ..zipper, focus }
	}

	## remove the right child, returns a new zipper
	remove_right : Zipper -> Zipper
	remove_right = |zipper| {
		focus = { ..zipper.focus, right: _ }
		{ ..zipper, focus }
	}
}
