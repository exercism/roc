CustomSet :: { items : List(U64) }.{
	Item : U64

	contains : CustomSet, Item -> Bool
	contains = |{ items }, item| items.contains(item)

	difference : CustomSet, CustomSet -> CustomSet
	difference = |{ items: items1 }, { items: items2 }| {
		{ items: items1.drop_if(|item| items2.contains(item)) }
	}

	from_list : List(Item) -> CustomSet
	from_list = |list| {
		match sort_asc(list) {
			[] => { items: [] }
			[first, .. as rest] => {
				state_res = rest.fold(
					{ items: [first], previous: first },
					|state, item| {
						if item == state.previous {
							state
						} else {
							{ items: state.items.append(item), previous: item }
						}
					},
				)
				{ items: state_res.items }
			}
		}
	}

	insert : CustomSet, Item -> CustomSet
	insert = |{ items }, item| {
		if items.contains(item) {
			{ items: items }
		} else {
			{ items: items.append(item) }
		}
	}

	intersection : CustomSet, CustomSet -> CustomSet
	intersection = |{ items: items1 }, { items: items2 }| {
		{ items: items1.keep_if(|item| items2.contains(item)) }
	}

	is_disjoint_with : CustomSet, CustomSet -> Bool
	is_disjoint_with = |set1, set2| {
		intersection(set1, set2).is_empty()
	}

	is_empty : CustomSet -> Bool
	is_empty = |{ items }| {
		items.is_empty()
	}

	is_eq : CustomSet, CustomSet -> Bool
	is_eq = |{ items: items1 }, { items: items2 }| {
		sort_asc(items1) == sort_asc(items2)
	}

	is_subset_of : CustomSet, CustomSet -> Bool
	is_subset_of = |{ items: items1 }, { items: items2 }| {
		items1.all(|item| items2.contains(item))
	}

	to_list : CustomSet -> List(Item)
	to_list = |{ items }| items

	union : CustomSet, CustomSet -> CustomSet
	union = |set1, set2| {
		set1.to_list().concat(set2.to_list())->from_list()
	}
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
