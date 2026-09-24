Tree := [Empty, Node(Node)].{
	Node := { value : U8, left : Tree ?? Empty, right : Tree ?? Empty }.{
		is_eq : _
	}

	is_eq : _

	from_traversals : { pre_order : List(U8), in_order : List(U8) } -> Try(Tree, _)
	from_traversals = |{ pre_order, in_order }| {
		crash "Please implement the 'from_traversals' function"
	}
}
