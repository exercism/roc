# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/satellite/canonical-data.json
# File last updated on 2026-09-19

import Tree

# Empty tree
expect {
	result = Tree.from_traversals({
		pre_order: [],
		in_order: [],
	})
	result == Ok(Empty)
}

# Tree with one item
expect {
	result = Tree.from_traversals({
		pre_order: ['a'],
		in_order: ['a'],
	})
	result == Ok(Node({ value: 'a' }))
}

# Tree with many items
expect {
	result = Tree.from_traversals({
		pre_order: ['a', 'i', 'x', 'f', 'r'],
		in_order: ['i', 'a', 'f', 'x', 'r'],
	})
	result == Ok(Node({ value: 'a', left: Node({ value: 'i' }), right: Node({ value: 'x', left: Node({ value: 'f' }), right: Node({ value: 'r' }) }) }))
}

# Reject traversals of different length
expect {
	result = Tree.from_traversals({
		pre_order: ['a', 'b'],
		in_order: ['b', 'a', 'r'],
	})
	result.is_err()
}

# Reject inconsistent traversals of same length
expect {
	result = Tree.from_traversals({
		pre_order: ['x', 'y', 'z'],
		in_order: ['a', 'b', 'c'],
	})
	result.is_err()
}

# Reject traversals with repeated items
expect {
	result = Tree.from_traversals({
		pre_order: ['a', 'b', 'a'],
		in_order: ['b', 'a', 'a'],
	})
	result.is_err()
}

# A degenerate binary tree
expect {
	result = Tree.from_traversals({
		pre_order: ['a', 'b', 'c', 'd'],
		in_order: ['d', 'c', 'b', 'a'],
	})
	result == Ok(Node({ value: 'a', left: Node({ value: 'b', left: Node({ value: 'c', left: Node({ value: 'd' }) }) }) }))
}

# Another degenerate binary tree
expect {
	result = Tree.from_traversals({
		pre_order: ['a', 'b', 'c', 'd'],
		in_order: ['a', 'b', 'c', 'd'],
	})
	result == Ok(Node({ value: 'a', right: Node({ value: 'b', right: Node({ value: 'c', right: Node({ value: 'd' }) }) }) }))
}

# Tree with many more items
expect {
	result = Tree.from_traversals({
		pre_order: ['a', 'b', 'd', 'g', 'h', 'c', 'e', 'f', 'i'],
		in_order: ['g', 'd', 'h', 'b', 'a', 'e', 'c', 'i', 'f'],
	})
	result == Ok(Node({ value: 'a', left: Node({ value: 'b', left: Node({ value: 'd', left: Node({ value: 'g' }), right: Node({ value: 'h' }) }) }), right: Node({ value: 'c', left: Node({ value: 'e' }), right: Node({ value: 'f', left: Node({ value: 'i' }) }) }) }))
}
