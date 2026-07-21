Octal :: {}.{
	parse : Str -> Try(U64, [InvalidNumStr])
	parse = |string| {
		if string == "" {
			Err(InvalidNumStr)
		} else {
			digits = string.to_utf8()->map_try(parse_octal_digit)?
			digits.fold_until(
				Ok(0),
				|acc_res, octal_digit| {
					match acc_res {
						Ok(number) => {
							if number > 0x1fffffffffffffff {
								Break(Err(InvalidNumStr))
							} else {
								Continue(Ok(U64.shift_left_by(number, 3) + octal_digit))
							}
						}
						Err(err) => Break(Err(err))
					}
				},
			)
		}
	}
}

parse_octal_digit : U8 -> Try(U64, [InvalidNumStr])
parse_octal_digit = |char| {
	if char >= '0' and char <= '7' {
		Ok((char - '0').to_u64())
	} else {
		Err(InvalidNumStr)
	}
}

# The following function should soon be available in Roc's builtins
map_try : i, (a -> Try(b, err)) -> Try(List(b), err) where [i.iter : i -> Iter(a)]
map_try = |list, func| {
	var $state = []
	for item in list {
		$state = $state.append(func(item)?)
	}
	Ok($state)
}