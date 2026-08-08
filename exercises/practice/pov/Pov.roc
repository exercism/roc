Pov :: {}.{
	Tree := [Empty, Node({ label : Str, children : Set(Tree) })].{

		## Are two trees equal?
		is_eq : _ # enable the default is_eq implementation for the Tree type

		## Return the tree from the point of view of the node with the given label.
		## Return Err(NotFound) if no such node is found.
		from_pov : Tree, Str -> Try(Tree, [NotFound, ..])
		from_pov = |tree, from| {
			crash "Please implement the 'from_pov' function"
		}

		## Return the labels of the nodes between the two given nodes
		## If either of these nodes don't exist, return Err(NotFound)
		path_to : Tree, Str, Str -> Try(List(Str), [NotFound, ..])
		path_to = |tree, from, to| {
			crash "Please implement the 'path_to' function"
		}
	}
}
