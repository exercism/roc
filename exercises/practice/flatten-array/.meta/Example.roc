FlattenArray :: {}.{
	NestedValue := [Value(I64), Null, NestedArray(List(NestedValue))]

	flatten : NestedValue -> List(I64)
	flatten = |array| {
		match array {
			NestedArray(list) => list->join_map(flatten)
			Value(value) => [value]
			Null => []
		}
	}
}

# The following function should soon be available in Roc's builtins
join_map = |list, func| {
	var $state = []
	for item in list {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}
