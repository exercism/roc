ScrabbleScore :: {}.{
	score : Str -> U64
	score = |word| {
		word
			.to_utf8()
			.map(letter_value)
			.sum()
	}
}

to_upper : U8 -> U8
to_upper = |letter| {
	if letter >= 'a' and letter <= 'z' {
		letter - 'a' + 'A'
	} else {
		letter
	}
}

letter_value : U8 -> U64
letter_value = |letter| {
	(_, val) = 
		[
			("AEIOULNRST", 1),
			("DG", 2),
			("BCMP", 3),
			("FHVWY", 4),
			("K", 5),
			("JX", 8),
			("QZ", 10),
		]
			.find_first(
				|(letters, _)| {
					letters
						->Str.to_utf8()
						.contains(to_upper(letter))
				},
			) ?? ("", 0)
	val
}
