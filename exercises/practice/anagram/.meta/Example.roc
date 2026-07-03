import unicode.Grapheme

Anagram :: {}.{
	find_anagrams : Str, List(Str) -> List(Str)
	find_anagrams = |subject, candidates| {
		candidates
			.drop_if(
				|word| {
					to_upper(word) == to_upper(subject)
				},
			)
			.keep_if(
				|word| {
					word->is_anagram_of(subject) ?? Bool.False
				},
			)
	}
}

to_upper = |text| {
	text
		.to_utf8()
		.map(
			|c| {
				if c >= 'a' and c <= 'z' {
					c - 'a' + 'A'
				} else {
					c
				}
			},
		)
		->Str.from_utf8()
		?? "Unreachable"
}

compare_graphemes : Str, Str -> _
compare_graphemes = |g1, g2| {
	s1 = g1.to_utf8()
	s2 = g2.to_utf8()
	cmp = 
		s1.map2(
			s2,
			|b1, b2| {
				(b1, b2)
			},
		)
			.fold_until(
				EQ,
				|_, (b1, b2)| {
					if b1 == b2 {
						Continue(EQ)
					} else if b1 < b2 {
						Break(LT)
					} else {
						Break(GT)
					}
				},
			)
	if cmp == EQ {
		s1.len().compare(s2.len())
	} else {
		cmp
	}
}

sorted_graphemes = |word| {
	graphemes = Grapheme.split(word)?
	graphemes.sort_with(compare_graphemes)->Ok
}

is_anagram_of = |word1, word2| {
	sorted1 = (word1->to_upper()->sorted_graphemes())?
	sorted2 = (word2->to_upper()->sorted_graphemes())?
	Ok((sorted1 == sorted2))
}
