Matrix :: {}.{
	column : Str, U64 -> Try(List(I64), _)
	column = |matrix_str, index| {
		crash "Please implement the 'column' function"
	}

	row : Str, U64 -> Try(List(I64), _)
	row = |matrix_str, index| {
		crash "Please implement the 'row' function"
	}
}
