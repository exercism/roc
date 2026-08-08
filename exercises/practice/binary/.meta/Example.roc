Binary :: {}.{
	decimal : Str -> Try(U64, [InvalidCharacter(U8)])
	decimal = |binary_str| {
		binary_str
			.to_utf8()
			.map_try(
				|char| {
					match char {
						'0' => Ok(0)
						'1' => Ok(1)
						c => Err(InvalidCharacter(c))
					}
				},
			)?
			.fold(
				0,
				|dec, bit| {
					dec * 2 + bit
				},
			)
			|> Ok
	}
}
