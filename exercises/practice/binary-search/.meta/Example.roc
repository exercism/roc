BinarySearch :: {}.{
	find : List(U64), U64 -> Try(U64, [ValueWasNotFound(List(U64), U64)])
	find = |array, value| {
		binary_search = |min_index, max_index| {
			middle_index = (min_index + max_index) // 2
			middle_value = array.get(middle_index)?
			if middle_value == value {
				Ok(middle_index)
			} else if min_index == max_index {
				Err(ValueWasNotFound(array, value))
			} else if middle_value < value {
				Ok(binary_search((middle_index + 1), max_index)?)
			} else {
				Ok(binary_search(min_index, (middle_index - 1))?)
			}
		}

		binary_search(0, array.len())
			.map_err(
				|_| ValueWasNotFound(array, value),
			)
	}
}
