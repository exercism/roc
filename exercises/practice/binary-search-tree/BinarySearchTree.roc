BinarySearchTree := [Nil, Node({ value : U64, left : BinarySearchTree, right : BinarySearchTree })].{
	from_list : List(U64) -> BinarySearchTree
	from_list = |data| {
		crash "Please implement the 'from_list' function"
	}

	to_list : BinarySearchTree -> List(U64)
	to_list = |tree| {
		crash "Please implement the 'to_list' function"
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _
}
