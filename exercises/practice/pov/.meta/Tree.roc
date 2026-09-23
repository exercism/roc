##
## Example solution
##

Tree := { label : Str, children : Set(Tree) }.{

	## Are two trees equal?
	is_eq : _ # enable the default is_eq implementation

	## Allow Trees to be hashed, which is required to add them to a Set
	to_hash : _ # enable the default to_hash implementation

	## Return the tree from the point of view of the node with the given label.
	## Return Err(NotFound) if no such node is found.
	from_pov : Tree, Str -> Try(Tree, [NotFound, ..])
	from_pov = |tree, from| {
		root_path = tree |> nodes_to_root(from)?
		match root_path.take_first(2) {
			[] => crash "Unreachable: nodes_to_root cannot return Ok([])"
			[_] => Ok(tree) # the target node is already the root of the tree
			[target, parent, ..] => {
				tree_without_target = tree |> drop(from)
				from_parent_pov = tree_without_target |> from_pov(parent.label)?
				children = target.children.insert(from_parent_pov)
				Ok({ label: from, children })
			}
		}
	}

	## Return the labels of the nodes between the two given nodes
	## If either of these nodes don't exist, return Err(NotFound)
	path_to : Tree, Str, Str -> Try(List(Str), [NotFound, ..])
	path_to = |tree, from, to| {
		tree
			|> from_pov(to)?
			|> nodes_to_root(from)?
			.map(|child| child.label)
			|> Ok
	}
}

## Return all nodes on the path from the target node up to the root.
## If the node is not found, Err(NotFound) is returned.
nodes_to_root : Tree, Str -> Try(List(Tree), [NotFound, ..])
nodes_to_root = |tree, label| {
	help : Tree, List(Tree) -> Try(List(Tree), [NotFound, ..])
	help = |subtree, path| {
		new_path = path.append(subtree)
		if subtree.label == label {
			Ok(new_path)
		} else {
			for child in subtree.children {
				result = help(child, new_path)
				if result.is_ok() return result
			}
			Err(NotFound)
		}
	}
	Ok(help(tree, [])?.rev())
}

## Drop nodes with the given label (excluding the root)
drop : Tree, Str -> Tree
drop = |tree, label| {
	children = tree.children
		.drop_if(|child| child.label == label)
		.map(|child| child |> drop(label))
	{ ..tree, children }
}
