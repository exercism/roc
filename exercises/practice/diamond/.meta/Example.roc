Diamond :: {}.{
	diamond : U8 -> Str
	diamond = |letter| {
		letter_index = (letter - 'A').to_i8_try() ?? {
			crash "Unreachable"
		}
		((-letter_index)..=letter_index)
			.map(
				|row_index| {
					((-letter_index)..=letter_index)
						.map(
							|col_index| get_char(row_index, col_index, letter_index),
						)
						->List.from_iter()
						->unwrap_from_utf8()
				},
			)
			->List.from_iter()
			->Str.join_with("\n")
	}
}

get_char : I8, I8, I8 -> U8
get_char = |row_index, col_index, letter_index| {
	if row_index.abs() + col_index.abs() == letter_index {
		(
			(letter_index - row_index.abs()).to_u8_try() ?? {
				crash "Unreachable"
			},
		) + 'A'
	} else {
		' '
	}
}

unwrap_from_utf8 : List(U8) -> Str
unwrap_from_utf8 = |chars| {
	match Str.from_utf8(chars) {
		Ok(result) => result
		Err(_) => {
			crash "Str.from_utf8 should never fail here"
		}
	}
}
