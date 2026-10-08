Tree := { label : Str, children : Set(Tree) }.{

	is_eq : _ # enable the default is_eq implementation

	to_hash : _ # enable the default to_hash implementation

	from_pov : Tree, Str -> Try(Tree, [NotFound])
	from_pov = |tree, from| {
		crash "Please implement the 'from_pov' function"
	}

	path_to : Tree, Str, Str -> Try(List(Str), [NotFound])
	path_to = |tree, from, to| {
		crash "Please implement the 'path_to' function"
	}
}
