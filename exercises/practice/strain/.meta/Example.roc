Strain :: {}.{
	keep : List(a), (a -> Bool) -> List(a)
	keep = |list, predicate| {
		var $result = []
		for item in list {
			if predicate(item) {
				$result = $result.append(item)
			}
		}
		$result
	}

	discard : List(a), (a -> Bool) -> List(a)
	discard = |list, predicate| {
		loop = |sub_list, non_discarded_items| {
			match sub_list {
				[] => non_discarded_items
				[first, .. as rest] => {
					if predicate(first) {
						rest->loop(non_discarded_items)
					} else {
						rest->loop(non_discarded_items.append(first))
					}
				}
			}
		}

		loop(list, [])
	}
}
