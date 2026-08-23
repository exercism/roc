FlattenArray :: {}.{
	NestedValue := [Value(I64), Null, NestedArray(List(NestedValue))]

	flatten : NestedValue -> List(I64)
	flatten = |array| {
		match array {
			NestedArray(list) => list.join_map(flatten)
			Value(value) => [value]
			Null => []
		}
	}
}
