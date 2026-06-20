# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/custom-set/canonical-data.json
# File last updated on 2026-06-20

import CustomSet

##
## Returns true if the set contains no elements
##

# sets with no elements are empty

expect {
	set = CustomSet.from_list([])
	result = set.is_empty()
	expected = Bool.True
	result == expected
}

# sets with elements are not empty

expect {
	set = CustomSet.from_list([1])
	result = set.is_empty()
	expected = Bool.False
	result == expected
}

##
## Sets can report if they contain an element
##

# nothing is contained in an empty set

expect {
	set = CustomSet.from_list([])
	result = set.contains(1)
	expected = Bool.False
	result == expected
}

# when the element is in the set

expect {
	set = CustomSet.from_list([1, 2, 3])
	result = set.contains(1)
	expected = Bool.True
	result == expected
}

# when the element is not in the set

expect {
	set = CustomSet.from_list([1, 2, 3])
	result = set.contains(4)
	expected = Bool.False
	result == expected
}

##
## A set is a subset if all of its elements are contained in the other set
##

# empty set is a subset of another empty set

expect {
	set1 = CustomSet.from_list([])
	set2 = CustomSet.from_list([])
	result = set1.is_subset_of(set2)
	expected = Bool.True
	result == expected
}

# empty set is a subset of non-empty set

expect {
	set1 = CustomSet.from_list([])
	set2 = CustomSet.from_list([1])
	result = set1.is_subset_of(set2)
	expected = Bool.True
	result == expected
}

# non-empty set is not a subset of empty set

expect {
	set1 = CustomSet.from_list([1])
	set2 = CustomSet.from_list([])
	result = set1.is_subset_of(set2)
	expected = Bool.False
	result == expected
}

# set is a subset of set with exact same elements

expect {
	set1 = CustomSet.from_list([1, 2, 3])
	set2 = CustomSet.from_list([1, 2, 3])
	result = set1.is_subset_of(set2)
	expected = Bool.True
	result == expected
}

# set is a subset of larger set with same elements

expect {
	set1 = CustomSet.from_list([1, 2, 3])
	set2 = CustomSet.from_list([4, 1, 2, 3])
	result = set1.is_subset_of(set2)
	expected = Bool.True
	result == expected
}

# set is not a subset of set that does not contain its elements

expect {
	set1 = CustomSet.from_list([1, 2, 3])
	set2 = CustomSet.from_list([4, 1, 3])
	result = set1.is_subset_of(set2)
	expected = Bool.False
	result == expected
}

##
## Sets are disjoint if they share no elements
##

# the empty set is disjoint with itself

expect {
	set1 = CustomSet.from_list([])
	set2 = CustomSet.from_list([])
	result = set1.is_disjoint_with(set2)
	expected = Bool.True
	result == expected
}

# empty set is disjoint with non-empty set

expect {
	set1 = CustomSet.from_list([])
	set2 = CustomSet.from_list([1])
	result = set1.is_disjoint_with(set2)
	expected = Bool.True
	result == expected
}

# non-empty set is disjoint with empty set

expect {
	set1 = CustomSet.from_list([1])
	set2 = CustomSet.from_list([])
	result = set1.is_disjoint_with(set2)
	expected = Bool.True
	result == expected
}

# sets are not disjoint if they share an element

expect {
	set1 = CustomSet.from_list([1, 2])
	set2 = CustomSet.from_list([2, 3])
	result = set1.is_disjoint_with(set2)
	expected = Bool.False
	result == expected
}

# sets are disjoint if they share no elements

expect {
	set1 = CustomSet.from_list([1, 2])
	set2 = CustomSet.from_list([3, 4])
	result = set1.is_disjoint_with(set2)
	expected = Bool.True
	result == expected
}

##
## Sets with the same elements are equal
##

# empty sets are equal

expect {
	set1 = CustomSet.from_list([])
	set2 = CustomSet.from_list([])
	result = set1.is_eq(set2)
	expected = Bool.True
	result == expected
}

# empty set is not equal to non-empty set

expect {
	set1 = CustomSet.from_list([])
	set2 = CustomSet.from_list([1, 2, 3])
	result = set1.is_eq(set2)
	expected = Bool.False
	result == expected
}

# non-empty set is not equal to empty set

expect {
	set1 = CustomSet.from_list([1, 2, 3])
	set2 = CustomSet.from_list([])
	result = set1.is_eq(set2)
	expected = Bool.False
	result == expected
}

# sets with the same elements are equal

expect {
	set1 = CustomSet.from_list([1, 2])
	set2 = CustomSet.from_list([2, 1])
	result = set1.is_eq(set2)
	expected = Bool.True
	result == expected
}

# sets with different elements are not equal

expect {
	set1 = CustomSet.from_list([1, 2, 3])
	set2 = CustomSet.from_list([1, 2, 4])
	result = set1.is_eq(set2)
	expected = Bool.False
	result == expected
}

# set is not equal to larger set with same elements

expect {
	set1 = CustomSet.from_list([1, 2, 3])
	set2 = CustomSet.from_list([1, 2, 3, 4])
	result = set1.is_eq(set2)
	expected = Bool.False
	result == expected
}

# set is equal to a set constructed from an array with duplicates

expect {
	set1 = CustomSet.from_list([1])
	set2 = CustomSet.from_list([1, 1])
	result = set1.is_eq(set2)
	expected = Bool.True
	result == expected
}

##
## Unique elements can be added to a set
##

# add to empty set

expect {
	set = CustomSet.from_list([])
	result = set.insert(3)
	expected = [3]->CustomSet.from_list()
	result.is_eq(expected)
}

# add to non-empty set

expect {
	set = CustomSet.from_list([1, 2, 4])
	result = set.insert(3)
	expected = [1, 2, 3, 4]->CustomSet.from_list()
	result.is_eq(expected)
}

# adding an existing element does not change the set

expect {
	set = CustomSet.from_list([1, 2, 3])
	result = set.insert(3)
	expected = [1, 2, 3]->CustomSet.from_list()
	result.is_eq(expected)
}

##
## Intersection returns a set of all shared elements
##

# intersection of two empty sets is an empty set

expect {
	set1 = CustomSet.from_list([])
	set2 = CustomSet.from_list([])
	result = set1.intersection(set2)
	expected = []->CustomSet.from_list()
	result.is_eq(expected)
}

# intersection of an empty set and non-empty set is an empty set

expect {
	set1 = CustomSet.from_list([])
	set2 = CustomSet.from_list([3, 2, 5])
	result = set1.intersection(set2)
	expected = []->CustomSet.from_list()
	result.is_eq(expected)
}

# intersection of a non-empty set and an empty set is an empty set

expect {
	set1 = CustomSet.from_list([1, 2, 3, 4])
	set2 = CustomSet.from_list([])
	result = set1.intersection(set2)
	expected = []->CustomSet.from_list()
	result.is_eq(expected)
}

# intersection of two sets with no shared elements is an empty set

expect {
	set1 = CustomSet.from_list([1, 2, 3])
	set2 = CustomSet.from_list([4, 5, 6])
	result = set1.intersection(set2)
	expected = []->CustomSet.from_list()
	result.is_eq(expected)
}

# intersection of two sets with shared elements is a set of the shared elements

expect {
	set1 = CustomSet.from_list([1, 2, 3, 4])
	set2 = CustomSet.from_list([3, 2, 5])
	result = set1.intersection(set2)
	expected = [2, 3]->CustomSet.from_list()
	result.is_eq(expected)
}

##
## Difference (or Complement) of a set is a set of all elements that are only in the first set
##

# difference of two empty sets is an empty set

expect {
	set1 = CustomSet.from_list([])
	set2 = CustomSet.from_list([])
	result = set1.difference(set2)
	expected = []->CustomSet.from_list()
	result.is_eq(expected)
}

# difference of empty set and non-empty set is an empty set

expect {
	set1 = CustomSet.from_list([])
	set2 = CustomSet.from_list([3, 2, 5])
	result = set1.difference(set2)
	expected = []->CustomSet.from_list()
	result.is_eq(expected)
}

# difference of a non-empty set and an empty set is the non-empty set

expect {
	set1 = CustomSet.from_list([1, 2, 3, 4])
	set2 = CustomSet.from_list([])
	result = set1.difference(set2)
	expected = [1, 2, 3, 4]->CustomSet.from_list()
	result.is_eq(expected)
}

# difference of two non-empty sets is a set of elements that are only in the first set

expect {
	set1 = CustomSet.from_list([3, 2, 1])
	set2 = CustomSet.from_list([2, 4])
	result = set1.difference(set2)
	expected = [1, 3]->CustomSet.from_list()
	result.is_eq(expected)
}

# difference removes all duplicates in the first set

expect {
	set1 = CustomSet.from_list([1, 1])
	set2 = CustomSet.from_list([1])
	result = set1.difference(set2)
	expected = []->CustomSet.from_list()
	result.is_eq(expected)
}

##
## Union returns a set of all elements in either set
##

# union of empty sets is an empty set

expect {
	set1 = CustomSet.from_list([])
	set2 = CustomSet.from_list([])
	result = set1.union(set2)
	expected = []->CustomSet.from_list()
	result.is_eq(expected)
}

# union of an empty set and non-empty set is the non-empty set

expect {
	set1 = CustomSet.from_list([])
	set2 = CustomSet.from_list([2])
	result = set1.union(set2)
	expected = [2]->CustomSet.from_list()
	result.is_eq(expected)
}

# union of a non-empty set and empty set is the non-empty set

expect {
	set1 = CustomSet.from_list([1, 3])
	set2 = CustomSet.from_list([])
	result = set1.union(set2)
	expected = [1, 3]->CustomSet.from_list()
	result.is_eq(expected)
}

# union of non-empty sets contains all unique elements

expect {
	set1 = CustomSet.from_list([1, 3])
	set2 = CustomSet.from_list([2, 3])
	result = set1.union(set2)
	expected = [3, 2, 1]->CustomSet.from_list()
	result.is_eq(expected)
}

##
## A set can be converted to a list of items
##

# an empty set has an empty list of items
expect {
	set = CustomSet.from_list([])
	result = set.to_list()->sort_asc()
	expected = []
	result == expected
}

# a set can provide the list of its items
expect {
	set = CustomSet.from_list([1, 2, 3, 4])
	result = set.to_list()->sort_asc()
	expected = [1, 2, 3, 4]
	result == expected
}

# duplicate items must be removed
expect {
	set = CustomSet.from_list([1, 2, 2, 3, 3, 3, 4, 4, 4, 4])
	result = set.to_list()->sort_asc()
	expected = [1, 2, 3, 4]
	result == expected
}

sort_asc = |list| {
	list.sort_with(
		|a, b| {
			if a < b {
				LT
			} else if a > b {
				GT
			} else {
				EQ
			}
		},
	)
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
