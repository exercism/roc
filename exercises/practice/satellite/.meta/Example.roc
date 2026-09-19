Tree := [Empty, Node(Node)].{
	Node := { value : U8, left : Tree ?? Empty, right : Tree ?? Empty }.{
		is_eq : _
	}

	is_eq : _

	from_traversals : { pre_order : List(U8), in_order : List(U8) } -> Try(Tree, [DifferentLengths, DuplicateItems, InconsistentTraversals, ..])
	from_traversals = |{ pre_order, in_order }| {
		if pre_order.len() != in_order.len() {
			return Err(DifferentLengths)
		}
		if Set.from_list(pre_order).len() != pre_order.len() {
			return Err(DuplicateItems)
		}
		match pre_order {
			[] => Ok(Empty)
			[root] => Ok(Node({ value: root, left: Empty, right: Empty }))
			[root, ..] => {
				root_index = in_order.find_first_index(|v| v == root) ? |NotFound| InconsistentTraversals
				left_pre_order = pre_order.sublist({ start: 1, len: root_index })
				right_pre_order = pre_order.sublist({ start: root_index + 1, len: pre_order.len() - root_index - 1 })
				left_in_order = in_order.sublist({ start: 0, len: root_index })
				right_in_order = in_order.sublist({ start: root_index + 1, len: in_order.len() - root_index - 1 })
				left = from_traversals({ pre_order: left_pre_order, in_order: left_in_order })?
				right = from_traversals({ pre_order: right_pre_order, in_order: right_in_order })?
				Ok(Node({ value: root, left, right }))
			}
		}
	}
}
