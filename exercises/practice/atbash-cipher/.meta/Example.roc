AtbashCipher :: {}.{
	encode : Str -> Try(Str, _)
	encode = |phrase| {
		(
			phrase
				.to_utf8()
				.join_map(
					|char| {
						if char >= 'A' and char <= 'Z' {
							[invert((char - 'A' + 'a'))]
						} else if char >= 'a' and char <= 'z' {
							[invert(char)]
						} else if char >= '0' and char <= '9' {
							[char]
						} else {
							[]
						}
					},
				)
				.chunks_of(5)
				.intersperse([' '])
		).join()
			|> Str.from_utf8
	}

	decode : Str -> Try(Str, _)
	decode = |phrase| {
		phrase
			.to_utf8()
			.drop_if(
				|c| {
					c == ' '
				},
			)
			.map(
				invert,
			)
			|> Str.from_utf8
	}
}

invert : U8 -> U8
invert = |char| {
	if char >= 'a' and char <= 'z' {
		'z' - char + 'a'
	} else {
		char
	}
}
