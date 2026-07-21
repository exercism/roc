Transpose :: {}.{
	# # Transpose the input string. Input string must be ASCII.
	transpose : Str -> Str
	transpose = |string| {
		chars = string.to_utf8().split_on('\n')
		get_char = |row, col| {
			chars.get(row)?.get(col)
		}
		max_width = chars.map(List.len).max() ?? 0
		(0..<max_width)
			.map(
				|col| {
					max_row = 
						chars
							.find_last_index(
								|row_chars| row_chars.len() > col,
							)
							?? 0

					(0..=max_row)
						.map(
							|row| get_char(row, col) ?? ' ',
						)
						->List.from_iter()
						->Str.from_utf8()
						?? ""
				},
			)
			->List.from_iter()
			->Str.join_with("\n")
	}
}
