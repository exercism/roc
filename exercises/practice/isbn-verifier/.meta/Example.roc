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
					->keep_oks(|v| v)
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

# The following functions should soon be available in Roc's builtins
keep_oks = |iter, func| {
	iter
		->join_map(
			|item| {
				match func(item) {
					Ok(result) => [result]
					Err(_) => []
				}
			},
		)
}

join_map : i, (a -> j) -> List(b) where [i.iter : i -> Iter(a), j.iter : j -> Iter(b)]
join_map = |list, func| {
	var $state = []
	for item in list {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}
