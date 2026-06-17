Knapsack :: {}.{
	maximum_value : { items : List(Item), maximum_weight : U64 } -> U64
	maximum_value = |{ items, maximum_weight }| {
		match items {
			[] => 0
			[item, .. as rest] => {
				max_value_without_item = maximum_value({ items: rest, maximum_weight })
				if item.weight > maximum_weight {
					max_value_without_item
				} else {
					max_value_with_item = item.value + maximum_value({ items: rest, maximum_weight: maximum_weight - item.weight })
					U64.max(max_value_without_item, max_value_with_item)
				}
			}
		}
	}
}

Item := { weight : U64, value : U64 }
