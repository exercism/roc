Isogram :: {}.{
	is_isogram : Str -> Bool
	is_isogram = |phrase| {
		chars = 
			phrase
				.to_utf8()
				.drop_if(
					|c| c == ' ' or c == '-',
				)
				.map(
					|c| {
						if c >= 'a' and c <= 'z' {
							c + 'A' - 'a'
						} else {
							c
						}
					},
				) # to uppercase

		chars.len() == chars->Set.from_list().len()
	}
}
