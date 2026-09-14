# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pov/canonical-data.json
# File last updated on 2026-09-09

import Tree

##
## Reroot a tree so that its root is the specified node.
##

# Results in the same tree if the input tree is a singleton

expect {
	tree : Tree
	tree = { label: "x", children: Set.empty() }
	result = tree.from_pov("x")
	expected = Ok({ label: "x", children: Set.empty() })
	result == expected
}

# Can reroot a tree with a parent and one sibling

expect {
	tree : Tree
	tree = {
		label: "parent",
		children: Set.from_list([
			{ label: "x", children: Set.empty() },
			{ label: "sibling", children: Set.empty() },
		]),
	}
	result = tree.from_pov("x")
	expected = Ok({
		label: "x",
		children: Set.from_list([
			{
				label: "parent",
				children: Set.from_list([
					{ label: "sibling", children: Set.empty() },
				]),
			},
		]),
	})
	result == expected
}

# Can reroot a tree with a parent and many siblings

expect {
	tree : Tree
	tree = {
		label: "parent",
		children: Set.from_list([
			{ label: "a", children: Set.empty() },
			{ label: "x", children: Set.empty() },
			{ label: "b", children: Set.empty() },
			{ label: "c", children: Set.empty() },
		]),
	}
	result = tree.from_pov("x")
	expected = Ok({
		label: "x",
		children: Set.from_list([
			{
				label: "parent",
				children: Set.from_list([
					{ label: "a", children: Set.empty() },
					{ label: "b", children: Set.empty() },
					{ label: "c", children: Set.empty() },
				]),
			},
		]),
	})
	result == expected
}

# Can reroot a tree with new root deeply nested in tree

expect {
	tree : Tree
	tree = {
		label: "level-0",
		children: Set.from_list([
			{
				label: "level-1",
				children: Set.from_list([
					{
						label: "level-2",
						children: Set.from_list([
							{
								label: "level-3",
								children: Set.from_list([
									{ label: "x", children: Set.empty() },
								]),
							},
						]),
					},
				]),
			},
		]),
	}
	result = tree.from_pov("x")
	expected = Ok({
		label: "x",
		children: Set.from_list([
			{
				label: "level-3",
				children: Set.from_list([
					{
						label: "level-2",
						children: Set.from_list([
							{
								label: "level-1",
								children: Set.from_list([
									{ label: "level-0", children: Set.empty() },
								]),
							},
						]),
					},
				]),
			},
		]),
	})
	result == expected
}

# Moves children of the new root to same level as former parent

expect {
	tree : Tree
	tree = {
		label: "parent",
		children: Set.from_list([
			{
				label: "x",
				children: Set.from_list([
					{ label: "kid-0", children: Set.empty() },
					{ label: "kid-1", children: Set.empty() },
				]),
			},
		]),
	}
	result = tree.from_pov("x")
	expected = Ok({
		label: "x",
		children: Set.from_list([
			{ label: "kid-0", children: Set.empty() },
			{ label: "kid-1", children: Set.empty() },
			{ label: "parent", children: Set.empty() },
		]),
	})
	result == expected
}

# Can reroot a complex tree with cousins

expect {
	tree : Tree
	tree = {
		label: "grandparent",
		children: Set.from_list([
			{
				label: "parent",
				children: Set.from_list([
					{
						label: "x",
						children: Set.from_list([
							{ label: "kid-0", children: Set.empty() },
							{ label: "kid-1", children: Set.empty() },
						]),
					},
					{ label: "sibling-0", children: Set.empty() },
					{ label: "sibling-1", children: Set.empty() },
				]),
			},
			{
				label: "uncle",
				children: Set.from_list([
					{ label: "cousin-0", children: Set.empty() },
					{ label: "cousin-1", children: Set.empty() },
				]),
			},
		]),
	}
	result = tree.from_pov("x")
	expected = Ok({
		label: "x",
		children: Set.from_list([
			{ label: "kid-1", children: Set.empty() },
			{ label: "kid-0", children: Set.empty() },
			{
				label: "parent",
				children: Set.from_list([
					{ label: "sibling-0", children: Set.empty() },
					{ label: "sibling-1", children: Set.empty() },
					{
						label: "grandparent",
						children: Set.from_list([
							{
								label: "uncle",
								children: Set.from_list([
									{ label: "cousin-0", children: Set.empty() },
									{ label: "cousin-1", children: Set.empty() },
								]),
							},
						]),
					},
				]),
			},
		]),
	})
	result == expected
}

# Errors if target does not exist in a singleton tree

expect {
	tree : Tree
	tree = { label: "x", children: Set.empty() }
	result = tree.from_pov("nonexistent")
	result == Err(NotFound)
}

# Errors if target does not exist in a large tree

expect {
	tree : Tree
	tree = {
		label: "parent",
		children: Set.from_list([
			{
				label: "x",
				children: Set.from_list([
					{ label: "kid-0", children: Set.empty() },
					{ label: "kid-1", children: Set.empty() },
				]),
			},
			{ label: "sibling-0", children: Set.empty() },
			{ label: "sibling-1", children: Set.empty() },
		]),
	}
	result = tree.from_pov("nonexistent")
	result == Err(NotFound)
}

##
## Given two nodes, find the path between them
##

# Can find path to parent

expect {
	tree : Tree
	tree = {
		label: "parent",
		children: Set.from_list([
			{ label: "x", children: Set.empty() },
			{ label: "sibling", children: Set.empty() },
		]),
	}
	result = tree.path_to("x", "parent")
	expected = Ok(["x", "parent"])
	result == expected
}

# Can find path to sibling

expect {
	tree : Tree
	tree = {
		label: "parent",
		children: Set.from_list([
			{ label: "a", children: Set.empty() },
			{ label: "x", children: Set.empty() },
			{ label: "b", children: Set.empty() },
			{ label: "c", children: Set.empty() },
		]),
	}
	result = tree.path_to("x", "b")
	expected = Ok(["x", "parent", "b"])
	result == expected
}

# Can find path to cousin

expect {
	tree : Tree
	tree = {
		label: "grandparent",
		children: Set.from_list([
			{
				label: "parent",
				children: Set.from_list([
					{
						label: "x",
						children: Set.from_list([
							{ label: "kid-0", children: Set.empty() },
							{ label: "kid-1", children: Set.empty() },
						]),
					},
					{ label: "sibling-0", children: Set.empty() },
					{ label: "sibling-1", children: Set.empty() },
				]),
			},
			{
				label: "uncle",
				children: Set.from_list([
					{ label: "cousin-0", children: Set.empty() },
					{ label: "cousin-1", children: Set.empty() },
				]),
			},
		]),
	}
	result = tree.path_to("x", "cousin-1")
	expected = Ok(["x", "parent", "grandparent", "uncle", "cousin-1"])
	result == expected
}

# Can find path not involving root

expect {
	tree : Tree
	tree = {
		label: "grandparent",
		children: Set.from_list([
			{
				label: "parent",
				children: Set.from_list([
					{ label: "x", children: Set.empty() },
					{ label: "sibling-0", children: Set.empty() },
					{ label: "sibling-1", children: Set.empty() },
				]),
			},
		]),
	}
	result = tree.path_to("x", "sibling-1")
	expected = Ok(["x", "parent", "sibling-1"])
	result == expected
}

# Can find path from nodes other than x

expect {
	tree : Tree
	tree = {
		label: "parent",
		children: Set.from_list([
			{ label: "a", children: Set.empty() },
			{ label: "x", children: Set.empty() },
			{ label: "b", children: Set.empty() },
			{ label: "c", children: Set.empty() },
		]),
	}
	result = tree.path_to("a", "c")
	expected = Ok(["a", "parent", "c"])
	result == expected
}

# Errors if destination does not exist

expect {
	tree : Tree
	tree = {
		label: "parent",
		children: Set.from_list([
			{
				label: "x",
				children: Set.from_list([
					{ label: "kid-0", children: Set.empty() },
					{ label: "kid-1", children: Set.empty() },
				]),
			},
			{ label: "sibling-0", children: Set.empty() },
			{ label: "sibling-1", children: Set.empty() },
		]),
	}
	result = tree.path_to("x", "nonexistent")
	result == Err(NotFound)
}

# Errors if source does not exist

expect {
	tree : Tree
	tree = {
		label: "parent",
		children: Set.from_list([
			{
				label: "x",
				children: Set.from_list([
					{ label: "kid-0", children: Set.empty() },
					{ label: "kid-1", children: Set.empty() },
				]),
			},
			{ label: "sibling-0", children: Set.empty() },
			{ label: "sibling-1", children: Set.empty() },
		]),
	}
	result = tree.path_to("nonexistent", "x")
	result == Err(NotFound)
}
