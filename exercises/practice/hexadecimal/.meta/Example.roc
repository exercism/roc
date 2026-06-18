Hexadecimal :: {}.{
	parse : Str -> Try(U64, [InvalidNumStr])
	parse = |string| {
		if string == "" {
			Err(InvalidNumStr)
		} else {
			digits = string.to_utf8()->map_try(parse_nibble)?
			digits.fold_until(
				Ok(0),
				|acc_res, nibble| {
					match acc_res {
						Ok(number) => {
							if number > 0xfffffffffffffff {
								Break(Err(InvalidNumStr))
							} else {
								Continue(Ok(U64.shift_left_by(number, 4) + nibble))
							}
						}
						Err(err) => Break(Err(err))
					}
				},
			)
		}
	}
}

parse_nibble : U8 -> Try(U64, _)
parse_nibble = |char| {
	if char >= '0' and char <= '9' {
		Ok((char - '0').to_u64())
	} else if char >= 'A' and char <= 'F' {
		Ok((char - 'A' + 10).to_u64())
	} else if char >= 'a' and char <= 'f' {
		Ok((char - 'a' + 10).to_u64())
	} else {
		Err(InvalidNumStr)
	}
}

map_try = |iter, func| {
	var $state = []
	for item in iter {
		$state = $state.append(func(item)?)
	}
	Ok($state)
}
