Strain :: {}.{
	keep : List(a), (a -> Bool) -> List(a)
	keep = |list, predicate| {
		loop = |sub_list, kept_items, predicate2| {
			match sub_list {
				[] => kept_items
				[first, .. as rest] => {
					if predicate2(first) {
						rest->loop(kept_items.append(first), predicate2)
					} else {
						rest->loop(kept_items, predicate2)
					}
				}
			}
		}

		loop(list, [], predicate)
	}

	discard : List(a), (a -> Bool) -> List(a)
	discard = |list, predicate| {
		loop = |sub_list, non_discarded_items, predicate2| {
			match sub_list {
				[] => non_discarded_items
				[first, .. as rest] => {
					if predicate2(first) {
						rest->loop(non_discarded_items, predicate2)
					} else {
						rest->loop(non_discarded_items.append(first), predicate2)
					}
				}
			}
		}

		loop(list, [], predicate)
	}
}

# TODO: remove predicate2 once https://github.com/roc-lang/roc/issues/9690 is fixed
