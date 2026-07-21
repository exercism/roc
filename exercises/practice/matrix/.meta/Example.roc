Matrix :: {}.{
	column : Str, U64 -> Try(List(I64), [BadNumStr, OutOfBounds, ..])
	column = |matrix_str, index| {
		if index == 0 {
			Err(OutOfBounds)
		} else {
			matrix = parse_matrix(matrix_str)?
			matrix->map_try(|r| r.get(index - 1))
		}
	}

	row : Str, U64 -> Try(List(I64), [BadNumStr, OutOfBounds, ..])
	row = |matrix_str, index| {
		if index == 0 {
			Err(OutOfBounds)
		} else {
			matrix = parse_matrix(matrix_str)?
			result = matrix.get(index - 1)?
			Ok(result)
		}
	}
}

parse_row : Str -> Try(List(I64), [BadNumStr, ..])
parse_row = |row_str| {
	row_str
		.trim()
		.split_on(" ")
		.map(Str.trim)
		.drop_if(Str.is_empty)
		->map_try(I64.from_str)
}

parse_matrix : Str -> Try(List(List(I64)), [BadNumStr, ..])
parse_matrix = |matrix_str| {
	matrix_str
		.split_on("\n")
		->map_try(parse_row)
}

# The following functions should soon be available in Roc's builtins
map_try : i, (a -> Try(b, err)) -> Try(List(b), err) where [i.iter : i -> Iter(a)]
map_try = |list, func| {
	var $state = []
	for item in list {
		$state = $state.append(func(item)?)
	}
	Ok($state)
}