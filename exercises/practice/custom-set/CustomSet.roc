CustomSet :: {
	# TODO: change this opaque type however you need
	todo1 : U64,
	todo2 : U64,
	todo3 : U64,
	# etc.
}.{
	Item : U64

	contains : CustomSet, Item -> Bool
	contains = |custom_set, item| {
		crash "Please implement the 'contains' function"
	}

	difference : CustomSet, CustomSet -> CustomSet
	difference = |custom_set1, custom_set2| {
		crash "Please implement the 'difference' function"
	}

	from_list : List(Item) -> CustomSet
	from_list = |list| {
		crash "Please implement the 'from_list' function"
	}

	insert : CustomSet, Item -> CustomSet
	insert = |custom_set, item| {
		crash "Please implement the 'insert' function"
	}

	intersection : CustomSet, CustomSet -> CustomSet
	intersection = |custom_set1, custom_set2| {
		crash "Please implement the 'intersection' function"
	}

	is_disjoint_with : CustomSet, CustomSet -> Bool
	is_disjoint_with = |set1, set2| {
		crash "Please implement the 'is_disjoint_with' function"
	}

	is_empty : CustomSet -> Bool
	is_empty = |custom_set| {
		crash "Please implement the 'is_empty' function"
	}

	is_eq : CustomSet, CustomSet -> Bool
	is_eq = |custom_set1, custom_set2| {
		crash "Please implement the 'is_eq' function"
	}

	is_subset_of : CustomSet, CustomSet -> Bool
	is_subset_of = |custom_set1, custom_set2| {
		crash "Please implement the 'is_subset_of' function"
	}

	to_list : CustomSet -> List(Item)
	to_list = |custom_set| {
		crash "Please implement the 'to_list' function"
	}

	union : CustomSet, CustomSet -> CustomSet
	union = |set1, set2| {
		crash "Please implement the 'union' function"
	}
}
