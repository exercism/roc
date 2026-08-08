# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pov/canonical-data.json
# File last updated on 2026-08-08

import Pov exposing [Tree]

##
## Reroot a tree so that its root is the specified node.
##

# Results in the same tree if the input tree is a singleton

expect {
	tree = Tree.(Node({ label: "x", children: Set.empty() }))
	result = tree.from_pov("x")
	expected = Ok(Node({ label: "x", children: Set.empty() }))
	result == expected
}

# Can reroot a tree with a parent and one sibling

expect {
	tree = Tree.(
		Node({
			label: "parent",
			children: Set.from_list([
				Node({ label: "x", children: Set.empty() }),
				Node({ label: "sibling", children: Set.empty() }),
			]),
		}),
	)
	result = tree.from_pov("x")
	expected = Ok(
		Node({
			label: "x",
			children: Set.from_list([

				Node({
					label: "parent",
					children: Set.from_list([
						Node({ label: "sibling", children: Set.empty() }),
					]),
				}),
			]),
		}),
	)
	result == expected
}

# Can reroot a tree with a parent and many siblings

expect {
	tree = Tree.(
		Node({
			label: "parent",
			children: Set.from_list([
				Node({ label: "a", children: Set.empty() }),
				Node({ label: "x", children: Set.empty() }),
				Node({ label: "b", children: Set.empty() }),
				Node({ label: "c", children: Set.empty() }),
			]),
		}),
	)
	result = tree.from_pov("x")
	expected = Ok(
		Node({
			label: "x",
			children: Set.from_list([

				Node({
					label: "parent",
					children: Set.from_list([
						Node({ label: "a", children: Set.empty() }),
						Node({ label: "b", children: Set.empty() }),
						Node({ label: "c", children: Set.empty() }),
					]),
				}),
			]),
		}),
	)
	result == expected
}

# Can reroot a tree with new root deeply nested in tree

expect {
	tree = Tree.(
		Node({
			label: "level-0",
			children: Set.from_list([

				Node({
					label: "level-1",
					children: Set.from_list([

						Node({
							label: "level-2",
							children: Set.from_list([

								Node({
									label: "level-3",
									children: Set.from_list([
										Node({ label: "x", children: Set.empty() }),
									]),
								}),
							]),
						}),
					]),
				}),
			]),
		}),
	)
	result = tree.from_pov("x")
	expected = Ok(
		Node({
			label: "x",
			children: Set.from_list([

				Node({
					label: "level-3",
					children: Set.from_list([

						Node({
							label: "level-2",
							children: Set.from_list([

								Node({
									label: "level-1",
									children: Set.from_list([
										Node({ label: "level-0", children: Set.empty() }),
									]),
								}),
							]),
						}),
					]),
				}),
			]),
		}),
	)
	result == expected
}

# Moves children of the new root to same level as former parent

expect {
	tree = Tree.(
		Node({
			label: "parent",
			children: Set.from_list([

				Node({
					label: "x",
					children: Set.from_list([
						Node({ label: "kid-0", children: Set.empty() }),
						Node({ label: "kid-1", children: Set.empty() }),
					]),
				}),
			]),
		}),
	)
	result = tree.from_pov("x")
	expected = Ok(
		Node({
			label: "x",
			children: Set.from_list([
				Node({ label: "kid-0", children: Set.empty() }),
				Node({ label: "kid-1", children: Set.empty() }),
				Node({ label: "parent", children: Set.empty() }),
			]),
		}),
	)
	result == expected
}

# Can reroot a complex tree with cousins

expect {
	tree = Tree.(
		Node({
			label: "grandparent",
			children: Set.from_list([

				Node({
					label: "parent",
					children: Set.from_list([

						Node({
							label: "x",
							children: Set.from_list([
								Node({ label: "kid-0", children: Set.empty() }),
								Node({ label: "kid-1", children: Set.empty() }),
							]),
						}),
						Node({ label: "sibling-0", children: Set.empty() }),
						Node({ label: "sibling-1", children: Set.empty() }),
					]),
				}),

				Node({
					label: "uncle",
					children: Set.from_list([
						Node({ label: "cousin-0", children: Set.empty() }),
						Node({ label: "cousin-1", children: Set.empty() }),
					]),
				}),
			]),
		}),
	)
	result = tree.from_pov("x")
	expected = Ok(
		Node({
			label: "x",
			children: Set.from_list([
				Node({ label: "kid-1", children: Set.empty() }),
				Node({ label: "kid-0", children: Set.empty() }),

				Node({
					label: "parent",
					children: Set.from_list([
						Node({ label: "sibling-0", children: Set.empty() }),
						Node({ label: "sibling-1", children: Set.empty() }),

						Node({
							label: "grandparent",
							children: Set.from_list([

								Node({
									label: "uncle",
									children: Set.from_list([
										Node({ label: "cousin-0", children: Set.empty() }),
										Node({ label: "cousin-1", children: Set.empty() }),
									]),
								}),
							]),
						}),
					]),
				}),
			]),
		}),
	)
	result == expected
}

# Errors if target does not exist in a singleton tree

expect {
	tree = Tree.(Node({ label: "x", children: Set.empty() }))
	result = tree.from_pov("nonexistent")
	result == Err(NotFound)
}

# Errors if target does not exist in a large tree

expect {
	tree = Tree.(
		Node({
			label: "parent",
			children: Set.from_list([

				Node({
					label: "x",
					children: Set.from_list([
						Node({ label: "kid-0", children: Set.empty() }),
						Node({ label: "kid-1", children: Set.empty() }),
					]),
				}),
				Node({ label: "sibling-0", children: Set.empty() }),
				Node({ label: "sibling-1", children: Set.empty() }),
			]),
		}),
	)
	result = tree.from_pov("nonexistent")
	result == Err(NotFound)
}

##
## Given two nodes, find the path between them
##

# Can find path to parent

expect {
	tree = Tree.(
		Node({
			label: "parent",
			children: Set.from_list([
				Node({ label: "x", children: Set.empty() }),
				Node({ label: "sibling", children: Set.empty() }),
			]),
		}),
	)
	result = tree.path_to("x", "parent")
	expected = Ok(["x", "parent"])
	result == expected
}

# Can find path to sibling

expect {
	tree = Tree.(
		Node({
			label: "parent",
			children: Set.from_list([
				Node({ label: "a", children: Set.empty() }),
				Node({ label: "x", children: Set.empty() }),
				Node({ label: "b", children: Set.empty() }),
				Node({ label: "c", children: Set.empty() }),
			]),
		}),
	)
	result = tree.path_to("x", "b")
	expected = Ok(["x", "parent", "b"])
	result == expected
}

# Can find path to cousin

expect {
	tree = Tree.(
		Node({
			label: "grandparent",
			children: Set.from_list([

				Node({
					label: "parent",
					children: Set.from_list([

						Node({
							label: "x",
							children: Set.from_list([
								Node({ label: "kid-0", children: Set.empty() }),
								Node({ label: "kid-1", children: Set.empty() }),
							]),
						}),
						Node({ label: "sibling-0", children: Set.empty() }),
						Node({ label: "sibling-1", children: Set.empty() }),
					]),
				}),

				Node({
					label: "uncle",
					children: Set.from_list([
						Node({ label: "cousin-0", children: Set.empty() }),
						Node({ label: "cousin-1", children: Set.empty() }),
					]),
				}),
			]),
		}),
	)
	result = tree.path_to("x", "cousin-1")
	expected = Ok(["x", "parent", "grandparent", "uncle", "cousin-1"])
	result == expected
}

# Can find path not involving root

expect {
	tree = Tree.(
		Node({
			label: "grandparent",
			children: Set.from_list([

				Node({
					label: "parent",
					children: Set.from_list([
						Node({ label: "x", children: Set.empty() }),
						Node({ label: "sibling-0", children: Set.empty() }),
						Node({ label: "sibling-1", children: Set.empty() }),
					]),
				}),
			]),
		}),
	)
	result = tree.path_to("x", "sibling-1")
	expected = Ok(["x", "parent", "sibling-1"])
	result == expected
}

# Can find path from nodes other than x

expect {
	tree = Tree.(
		Node({
			label: "parent",
			children: Set.from_list([
				Node({ label: "a", children: Set.empty() }),
				Node({ label: "x", children: Set.empty() }),
				Node({ label: "b", children: Set.empty() }),
				Node({ label: "c", children: Set.empty() }),
			]),
		}),
	)
	result = tree.path_to("a", "c")
	expected = Ok(["a", "parent", "c"])
	result == expected
}

# Errors if destination does not exist

expect {
	tree = Tree.(
		Node({
			label: "parent",
			children: Set.from_list([

				Node({
					label: "x",
					children: Set.from_list([
						Node({ label: "kid-0", children: Set.empty() }),
						Node({ label: "kid-1", children: Set.empty() }),
					]),
				}),
				Node({ label: "sibling-0", children: Set.empty() }),
				Node({ label: "sibling-1", children: Set.empty() }),
			]),
		}),
	)
	result = tree.path_to("x", "nonexistent")
	result == Err(NotFound)
}

# Errors if source does not exist

expect {
	tree = Tree.(
		Node({
			label: "parent",
			children: Set.from_list([

				Node({
					label: "x",
					children: Set.from_list([
						Node({ label: "kid-0", children: Set.empty() }),
						Node({ label: "kid-1", children: Set.empty() }),
					]),
				}),
				Node({ label: "sibling-0", children: Set.empty() }),
				Node({ label: "sibling-1", children: Set.empty() }),
			]),
		}),
	)
	result = tree.path_to("nonexistent", "x")
	result == Err(NotFound)
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
