# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/strain/canonical-data.json
# File last updated on 2026-06-13

import Strain exposing [keep, discard]

# keep on empty list returns empty list
expect {
	list = []
	result = list->keep(|_| Bool.True)
	expected = []
	result == expected
}

# keeps everything
expect {
	list = [1, 3, 5]
	result = list->keep(|_| Bool.True)
	expected = [1, 3, 5]
	result == expected
}

# keeps nothing
expect {
	list = [1, 3, 5]
	result = list->keep(|_| Bool.False)
	expected = []
	result == expected
}

# keeps first and last
expect {
	list = [1, 2, 3]
	result = list->keep(|x| x % 2 == 1)
	expected = [1, 3]
	result == expected
}

# keeps neither first nor last
expect {
	list = [1, 2, 3]
	result = list->keep(|x| x % 2 == 0)
	expected = [2]
	result == expected
}

# keeps strings
expect {
	list = ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"]
	result = list->keep(|x| x.starts_with("z"))
	expected = ["zebra", "zombies", "zealot"]
	result == expected
}

# keeps lists
expect {
	list = [[1, 2, 3], [5, 5, 5], [5, 1, 2], [2, 1, 2], [1, 5, 2], [2, 2, 1], [1, 2, 5]]
	result = list->keep(|x| x.contains(5))
	expected = [[5, 5, 5], [5, 1, 2], [1, 5, 2], [1, 2, 5]]
	result == expected
}

# discard on empty list returns empty list
expect {
	list = []
	result = list->discard(|_| Bool.True)
	expected = []
	result == expected
}

# discards everything
expect {
	list = [1, 3, 5]
	result = list->discard(|_| Bool.True)
	expected = []
	result == expected
}

# discards nothing
expect {
	list = [1, 3, 5]
	result = list->discard(|_| Bool.False)
	expected = [1, 3, 5]
	result == expected
}

# discards first and last
expect {
	list = [1, 2, 3]
	result = list->discard(|x| x % 2 == 1)
	expected = [2]
	result == expected
}

# discards neither first nor last
expect {
	list = [1, 2, 3]
	result = list->discard(|x| x % 2 == 0)
	expected = [1, 3]
	result == expected
}

# discards strings
expect {
	list = ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"]
	result = list->discard(|x| x.starts_with("z"))
	expected = ["apple", "banana", "cherimoya"]
	result == expected
}

# discards lists
expect {
	list = [[1, 2, 3], [5, 5, 5], [5, 1, 2], [2, 1, 2], [1, 5, 2], [2, 2, 1], [1, 2, 5]]
	result = list->discard(|x| x.contains(5))
	expected = [[1, 2, 3], [2, 1, 2], [2, 2, 1]]
	result == expected
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
