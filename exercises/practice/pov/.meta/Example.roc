Pov :: {}.{
	Tree := [Empty, Node({ label : Str, children : Set(Tree) })].{

		## Are two trees equal?
		is_eq : _ # enable the default is_eq implementation for the Tree type

		## Return the tree from the point of view of the node with the given label.
		## Return Err(NotFound) if no such node is found.
		from_pov : Tree, Str -> Try(Tree, [NotFound, ..])
		from_pov = |tree, from| {
			root_path = tree |> nodes_to_root(from)?
			match root_path.first() {
				Err(ListWasEmpty) => {
					crash "Unreachable: nodes_to_root cannot return Ok([])"
				}
				Ok(Empty) => {
					crash "Unreachable: target cannot be Empty"
				}
				Ok(Node(target)) => {
					parent = root_path.get(1) ?? Empty
					match parent {
						Empty => Ok(tree) # the target node is already the root of the tree
						Node(parent_node) => {
							tree_without_target = tree |> drop(from)
							from_parent_pov = tree_without_target |> from_pov(parent_node.label)?
							new_children = target.children.insert(from_parent_pov)
							Node({ label: from, children: new_children }) |> Ok
						}
					}
				}
			}
		}

		## Find the list of nodes between the two given nodes and return their labels
		## If either of these nodes don't exist, return Err(NotFound)
		path_to : Tree, Str, Str -> Try(List(Str), [NotFound, ..])
		path_to = |tree, from, to| {
			from_tree = tree |> from_pov(to)?
			from_tree
				|> nodes_to_root(from)?
				.map(
					|child| {
						match child {
							Empty => {
								crash "Unreachable: trees must never contain Empty children"
							}
							Node(node) => node.label
						}
					},
				)
				|> Ok
		}
	}
}

## Return all nodes on the path from the target node up to the root.
## If the node is not found, Err(NotFound) is returned.
nodes_to_root : Pov.Tree, Str -> Try(List(Pov.Tree), [NotFound, ..])
nodes_to_root = |tree, label| {
	match tree {
		Empty => Err(NotFound)
		Node(node) => {
			if node.label == label
				Ok([Node(node)])
					else {
						node.children
							.to_list()
							.fold_until(
								Err(NotFound),
								|state, child| {
									match child |> nodes_to_root(label) {
										Ok(subPath) => Break(Ok(subPath.append(Node(node))))
										Err(NotFound) => Continue(state)
									}
								},
							)
					}
		}
	}
}

## Drop the node with the given label, if it exists
drop : Pov.Tree, Str -> Pov.Tree
drop = |tree, label| {
	match tree {
		Empty => Empty
		Node(node) => {
			if node.label == label {
				Empty
			} else {
				filtered_children =
					node.children
						.map(|child| drop(child, label))
						.drop_if(|child| child == Empty)
				Node({ label: node.label, children: filtered_children })
			}
		}
	}
}
