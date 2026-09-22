# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/zipper/canonical-data.json
# File last updated on 2026-09-16

import Zipper

default_tree : Zipper.Tree
default_tree = { value: 1, left: { value: 2, right: { value: 3 } }, right: { value: 4 } }

# data is retained
expect {
	zipper = default_tree.to_zipper()
	result = zipper.to_tree()
	result == default_tree
}

# left, right and value
expect {
	zipper = default_tree.to_zipper()
	result = zipper.left()?.right()?.value()
	result == 3
}

# dead end
expect {
	zipper = default_tree.to_zipper()
	result = zipper.left()?.left()
	result.is_err()
}

# tree from deep focus
expect {
	zipper = default_tree.to_zipper()
	result = zipper.left()?.right()?.to_tree()
	result == default_tree
}

# traversing up from top
expect {
	zipper = default_tree.to_zipper()
	result = zipper.up()
	result.is_err()
}

# left, right, and up
expect {
	zipper = default_tree.to_zipper()
	result = zipper.left()?.up()?.right()?.up()?.left()?.right()?.value()
	result == 3
}

# test ability to descend multiple levels and return
expect {
	zipper = default_tree.to_zipper()
	result = zipper.left()?.right()?.up()?.up()?.value()
	result == 1
}

# set_value
expect {
	zipper = default_tree.to_zipper()
	result = zipper.left()?.set_value(5).to_tree()
	result == { value: 1, left: { value: 5, right: { value: 3 } }, right: { value: 4 } }
}

# set_value after traversing up
expect {
	zipper = default_tree.to_zipper()
	result = zipper.left()?.right()?.up()?.set_value(5).to_tree()
	result == { value: 1, left: { value: 5, right: { value: 3 } }, right: { value: 4 } }
}

# set_left with leaf
expect {
	zipper = default_tree.to_zipper()
	result = zipper.left()?.set_left({ value: 5 }).to_tree()
	result == { value: 1, left: { value: 2, left: { value: 5 }, right: { value: 3 } }, right: { value: 4 } }
}

# remove right child
expect {
	zipper = default_tree.to_zipper()
	result = zipper.left()?.remove_right().to_tree()
	result == { value: 1, left: { value: 2 }, right: { value: 4 } }
}

# set_right with subtree
expect {
	zipper = default_tree.to_zipper()
	result = zipper.set_right({ value: 6, left: { value: 7 }, right: { value: 8 } }).to_tree()
	result == { value: 1, left: { value: 2, right: { value: 3 } }, right: { value: 6, left: { value: 7 }, right: { value: 8 } } }
}

# set_value on deep focus
expect {
	zipper = default_tree.to_zipper()
	result = zipper.left()?.right()?.set_value(5).to_tree()
	result == { value: 1, left: { value: 2, right: { value: 5 } }, right: { value: 4 } }
}

# different paths to same zipper
expect {
	zipper = default_tree.to_zipper()
	result1 = zipper.left()?.up()?.right()?
	result2 = zipper.right()?
	result1 == result2
}

# remove left child
expect {
	zipper = default_tree.to_zipper()
	result = zipper.remove_left().to_tree()
	result == { value: 1, right: { value: 4 } }
}
