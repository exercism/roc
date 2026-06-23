FlattenArray :: {}.{
	NestedValue := [Value(I64), Null, NestedArray(List(NestedValue))]

	flatten : NestedValue -> List(I64)
	flatten = |array| {
		crash "Please implement the 'flatten' function"
	}
}

# The following function should soon be available in Roc's builtins
join_map = |iter, func| {
	var $state = []
	for item in iter {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}
