PigLatin :: {}.{
	translate : Str -> Str
	translate = |phrase| {
		phrase
			.split_on(" ")
			.map(translate_word)
			->Str.join_with(" ")
	}
}

is_vowel = |char| {
	['a', 'e', 'i', 'o', 'u'].contains(char)
}

rule1_applies = |chars| {
	match chars {
		[c, ..] if is_vowel(c) => Bool.True
		['x', 'r', ..] => Bool.True
		['y', 't', ..] => Bool.True
		_ => Bool.False
	}
}

pig_latin_swap = |chars| {
	if rule1_applies(chars) {
		chars
	} else {
		(_, split_index) = 
			chars
				.fold_until(
					(0, 0),
					|(previous_char, index), char| {
						match (previous_char, char) {
							('q', 'u') => Break((0, index + 1))
							(_, 'y') if index > 0 => Break((0, index))
							(_, c) if is_vowel(c) => Break((0, index))
							_ => Continue((char, index + 1))
						}
					},
				)
		{ before, others } = chars.split_at(split_index)
		others.concat(before)
	}
}

translate_word : Str -> Str
translate_word = |word| {
	maybe_result = 
		word
			.to_utf8()
			->pig_latin_swap()
			.concat(['a', 'y'])
			->Str.from_utf8()
	match maybe_result {
		Ok(result) => result
		Err(_) => {
			crash "Unreachable"
		}
	}
}
