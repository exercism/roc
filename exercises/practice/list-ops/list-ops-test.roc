# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/list-ops/canonical-data.json
# File last updated on 2026-06-20

import ListOps exposing [concat, join, filter, len, map, fold, fold_rev, reverse]

##
## append entries to a list and return the new list
##

# empty lists
expect {
	result = []->concat([])
	result == []
}

# list to empty list
expect {
	result = []->concat([1, 2, 3, 4])
	result == [1, 2, 3, 4]
}

# empty list to list
expect {
	result = [1, 2, 3, 4]->concat([])
	result == [1, 2, 3, 4]
}

# non-empty lists
expect {
	result = [1, 2]->concat([2, 3, 4, 5])
	result == [1, 2, 2, 3, 4, 5]
}

##
## concatenate a list of lists
##

# empty list
expect {
	result = []->join()
	result == []
}

# list of lists
expect {
	result = [[1, 2], [3], [], [4, 5, 6]]->join()
	result == [1, 2, 3, 4, 5, 6]
}

# list of nested lists
expect {
	result = [[[1], [2]], [[3]], [[]], [[4, 5, 6]]]->join()
	result == [[1], [2], [3], [], [4, 5, 6]]
}

##
## filter list returning only values that satisfy the filter function
##

# empty list
expect {
	result = []->filter(|n| n % 2 == 1)
	result == []
}

# non-empty list
expect {
	result = [1, 2, 3, 5]->filter(|n| n % 2 == 1)
	result == [1, 3, 5]
}

##
## returns the length of a list
##

# empty list
expect {
	result = []->len()
	result == 0
}

# non-empty list
expect {
	result = [1, 2, 3, 4]->len()
	result == 4
}

##
## return a list of elements whose values equal the list value transformed by the mapping function
##

# empty list
expect {
	result = []->map(|x| x + 1)
	result == []
}

# non-empty list
expect {
	result = [1, 3, 5, 7]->map(|x| x + 1)
	result == [2, 4, 6, 8]
}

##
## folds (reduces) the given list from the left with a function
##

# empty list
expect {
	result = []->fold(2, |acc, el| el * acc)
	result == 2
}

# direction independent function applied to non-empty list
expect {
	result = [1, 2, 3, 4]->fold(5, |acc, el| el + acc)
	result == 15
}

# direction dependent function applied to non-empty list
expect {
	result = [1, 2, 3, 4]->fold(24, |acc, el| el / acc)->round()
	result == 64
}

##
## folds (reduces) the given list from the right with a function
##

# empty list
expect {
	result = []->fold_rev(2, |acc, el| el * acc)
	result == 2
}

# direction independent function applied to non-empty list
expect {
	result = [1, 2, 3, 4]->fold_rev(5, |acc, el| el + acc)
	result == 15
}

# direction dependent function applied to non-empty list
expect {
	result = [1, 2, 3, 4]->fold_rev(24, |acc, el| el / acc)->round()
	result == 9
}

##
## reverse the elements of the list
##

# empty list
expect {
	result = []->reverse()
	result == []
}

# non-empty list
expect {
	result = [1, 3, 5, 7]->reverse()
	result == [7, 5, 3, 1]
}

# list of lists is not flattened
expect {
	result = [[1, 2], [3], [], [4, 5, 6]]->reverse()
	result == [[4, 5, 6], [], [3], [1, 2]]
}

# The following function will soon be available in Roc's builtins
round : Dec -> Dec
round = |value| {
	pow = 1000.0
	(
		(value * pow + 0.5).to_u64_try() ?? {
			crash "Unreachable"
		},
	).to_dec() / pow
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
