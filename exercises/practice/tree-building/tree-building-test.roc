# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/tree-building/canonical-data.json
# File last updated on 2026-09-20

import Tree

# empty list
expect {
	result = Tree.from_records([])
	result.is_err()
}

# single record
expect {
	result = Tree.from_records([{ id: 0, parent_id: 0 }])
	result == Ok({ id: 0 })
}

# three records in order
expect {
	result = Tree.from_records([{ id: 0, parent_id: 0 }, { id: 1, parent_id: 0 }, { id: 2, parent_id: 0 }])
	result == Ok({ id: 0, children: [{ id: 1 }, { id: 2 }] })
}

# three records in reverse order
expect {
	result = Tree.from_records([{ id: 2, parent_id: 0 }, { id: 1, parent_id: 0 }, { id: 0, parent_id: 0 }])
	result == Ok({ id: 0, children: [{ id: 1 }, { id: 2 }] })
}

# more than two children
expect {
	result = Tree.from_records([{ id: 0, parent_id: 0 }, { id: 1, parent_id: 0 }, { id: 2, parent_id: 0 }, { id: 3, parent_id: 0 }])
	result == Ok({ id: 0, children: [{ id: 1 }, { id: 2 }, { id: 3 }] })
}

# binary tree
expect {
	result = Tree.from_records([{ id: 5, parent_id: 1 }, { id: 3, parent_id: 2 }, { id: 2, parent_id: 0 }, { id: 4, parent_id: 1 }, { id: 1, parent_id: 0 }, { id: 0, parent_id: 0 }, { id: 6, parent_id: 2 }])
	result == Ok({ id: 0, children: [{ id: 1, children: [{ id: 4 }, { id: 5 }] }, { id: 2, children: [{ id: 3 }, { id: 6 }] }] })
}

# unbalanced tree
expect {
	result = Tree.from_records([{ id: 5, parent_id: 2 }, { id: 3, parent_id: 2 }, { id: 2, parent_id: 0 }, { id: 4, parent_id: 1 }, { id: 1, parent_id: 0 }, { id: 0, parent_id: 0 }, { id: 6, parent_id: 2 }])
	result == Ok({ id: 0, children: [{ id: 1, children: [{ id: 4 }] }, { id: 2, children: [{ id: 3 }, { id: 5 }, { id: 6 }] }] })
}

# one root node and has parent
expect {
	result = Tree.from_records([{ id: 0, parent_id: 1 }])
	result.is_err()
}

# root node has parent
expect {
	result = Tree.from_records([{ id: 0, parent_id: 1 }, { id: 1, parent_id: 0 }])
	result.is_err()
}

# no root node
expect {
	result = Tree.from_records([{ id: 1, parent_id: 0 }, { id: 2, parent_id: 0 }])
	result.is_err()
}

# duplicate node
expect {
	result = Tree.from_records([{ id: 0, parent_id: 0 }, { id: 1, parent_id: 0 }, { id: 1, parent_id: 0 }])
	result.is_err()
}

# duplicate root
expect {
	result = Tree.from_records([{ id: 0, parent_id: 0 }, { id: 0, parent_id: 0 }])
	result.is_err()
}

# non-continuous
expect {
	result = Tree.from_records([{ id: 2, parent_id: 0 }, { id: 4, parent_id: 2 }, { id: 1, parent_id: 0 }, { id: 0, parent_id: 0 }])
	result.is_err()
}

# cycle directly
expect {
	result = Tree.from_records([{ id: 5, parent_id: 2 }, { id: 3, parent_id: 2 }, { id: 2, parent_id: 2 }, { id: 4, parent_id: 1 }, { id: 1, parent_id: 0 }, { id: 0, parent_id: 0 }, { id: 6, parent_id: 3 }])
	result.is_err()
}

# cycle indirectly
expect {
	result = Tree.from_records([{ id: 5, parent_id: 2 }, { id: 3, parent_id: 2 }, { id: 2, parent_id: 6 }, { id: 4, parent_id: 1 }, { id: 1, parent_id: 0 }, { id: 0, parent_id: 0 }, { id: 6, parent_id: 3 }])
	result.is_err()
}

# higher id parent of lower id
expect {
	result = Tree.from_records([{ id: 0, parent_id: 0 }, { id: 2, parent_id: 0 }, { id: 1, parent_id: 2 }])
	result.is_err()
}
