WordSearch :: {}.{
	Position : { column : U64, row : U64 }
	WordLocation : { start : Position, end : Position }

	search : Str, List(Str) -> Dict(Str, WordLocation)
	search = |grid, words_to_search_for| {
		{ rows, width } = pad_right(grid.to_utf8().split_on('\n'))
		height = rows.len()
		height_i64 = height.to_i64_try() ?? 0
		width_i64 = width.to_i64_try() ?? 0
		max_length = (
			if width > height {
				width
			} else {
				height
			},
		).to_i64_try() ?? 0

		# for all possible starting positions:
		(0..<width)->join_map(
			|column_index| {
				(0..<height)->join_map(
					|row_index| {
						# for all possible directions:
						[(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
							->join_map(
								|dir| {
									(dir_column, dir_row) = dir
									start = { column: column_index + 1, row: row_index + 1 }
									# for all possible lengths:
									(0..<max_length)
										->List.from_iter()
										.fold_until(
											{ found_words: [], chars: [] },
											|state, index| {
												end_column_index = (column_index.to_i64_try() ?? 0) + dir_column * index
												end_row_index = (row_index.to_i64_try() ?? 0) + dir_row * index
												if end_column_index < 0 or end_column_index >= width_i64 or end_row_index < 0 or end_row_index >= height_i64 {
													Break(state)
												} else {
													end_column_index_u64 = end_column_index.to_u64_try() ?? 0
													end_row_index_u64 = end_row_index.to_u64_try() ?? 0
													char = get_char(rows, end_column_index_u64, end_row_index_u64)
													new_chars = state.chars.append(char)
													end = { column: end_column_index_u64 + 1, row: end_row_index_u64 + 1 }
													maybe_word = words_to_search_for.find_first(|word| word.to_utf8() == new_chars)
													new_found_words = 
														match maybe_word {
															Ok(word) => state.found_words.append((word, { start, end }))
															Err(NotFound) => state.found_words
														}
													Continue({ found_words: new_found_words, chars: new_chars })
												}
											},
										)
										.found_words
								},
							)
					},
				)
			},
		)
			->Dict.from_list()
	}
}

## Pad each row with spaces to ensure all rows have the same width
pad_right : List(List(U8)) -> { rows : List(List(U8)), width : U64 }
pad_right = |grid| {
	width = grid.map(List.len).fold(
		0,
		|max_val, len| if len > max_val {
			len
		} else {
			max_val
		},
	)
	pad_spaces = |chars| List.repeat(' ', (width - chars.len()))
	{
		rows: grid.map(|chars| chars.concat(pad_spaces(chars))),
		width,
	}
}

get_char : List(List(U8)), U64, U64 -> U8
get_char = |grid, column_index, row_index| {
	row = grid.get(row_index) ?? []
	row.get(column_index) ?? ' '
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
