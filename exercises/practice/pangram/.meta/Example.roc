Pangram :: {}.{
	is_pangram : Str -> Bool
	is_pangram = |sentence| {
		sentence
			.to_utf8()
			->Set.from_list()
			.map(
				|c| if c >= 'a' and c <= 'z' {
					c + 'A' - 'a'
				} else {
					c
				},
			)
			.keep_if(
				|c| c >= 'A' and c <= 'Z',
			)
			== alphabet
	}
}

alphabet = 
	('A'..='Z')
		.fold(
			Set.empty(),
			|set, c| set.insert(c),
		)
