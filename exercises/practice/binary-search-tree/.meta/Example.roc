BinarySearchTree := [Nil, Node({ value : U64, left : BinarySearchTree, right : BinarySearchTree })].{
	from_list : List(U64) -> BinarySearchTree
	from_list = |data| {
		data.fold(Nil, insert)
	}

	to_list : BinarySearchTree -> List(U64)
	to_list = |tree| {
		match tree {
			Nil => []
			Node(node) => {
				to_list(node.left).append(node.value).concat(to_list(node.right))
			}
		}
	}

	insert : BinarySearchTree, U64 -> BinarySearchTree
	insert = |tree, value| {
		match tree {
			Nil => Node({ value, left: Nil, right: Nil })
			Node(node) => {
				if value <= node.value {
					Node({ ..node, left: node.left.insert(value) })
				} else {
					Node({ ..node, right: node.right.insert(value) })
				}
			}
		}
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _
}
