IsbnVerifier :: {}.{
	is_valid : Str -> Bool
	is_valid = |isbn| {
		chars =
			isbn
				.to_utf8()
				.drop_if(
					|char| char == '-',
				)
		if chars.len() != 10 {
			Bool.False
		} else {
			values : List(U64)
			values =
				chars
					.map_with_index(
						char_value,
					)
					.keep_oks(|v| v)
			values.len() == 10 and (values.sum()) % 11 == 0
		}
	}
}

char_value : U8, U64 -> Try(U64, _)
char_value = |char, index| {
	if char == 'X' {
		if index == 9 {
			Ok(10)
		} else {
			Err(InvalidIsbnBadX)
		}
	} else if char >= '0' and char <= '9' {
		Ok((10 - index) * (char - '0').to_u64())
	} else {
		Err(InvalidIsbnBadChar)
	}
}
