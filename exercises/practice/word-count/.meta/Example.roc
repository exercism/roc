WordCount :: {}.{
	count_words : Str -> Dict(Str, U64)
	count_words = |sentence| {
		all_words = 
			sentence
				.to_utf8()
				.append(' ')
				.fold(
					{ words: [], word: [], contraction_started: Bool.False },
					|state, char| {
						{ words, word, contraction_started } = state
						if char >= 'A' and char <= 'Z' {
							{ words, word: word.append(char - 'A' + 'a'), contraction_started: Bool.False }
						} else if (char >= 'a' and char <= 'z') or (char >= '0' and char <= '9') {
							{ words, word: word.append(char), contraction_started: Bool.False }
						} else {
							if word.is_empty() {
								state
							} else if char != '\'' or contraction_started {
								if contraction_started {
									{ words: words.append(word.drop_last(1)), word: [], contraction_started: Bool.False }
								} else {
									{ words: words.append(word), word: [], contraction_started: Bool.False }
								}
							} else {
								{ words, word: word.append(char), contraction_started: Bool.True }
							}
						}
					},
				)
				.words
				.drop_if(List.is_empty)

		all_words.fold(
			Dict.empty(),
			|result, chars| {
				word = 
					match Str.from_utf8(chars) {
						Ok(parsed_word) => parsed_word
						Err(BadUtf8(_)) => {
							crash "Unreachable: we only use ASCII characters"
						}
					}
				result.update(
					word,
					|maybe_count| {
						match maybe_count {
							Ok(count) => Ok(count + 1)
							Err(Missing) => Ok(1)
						}
					},
				)
			},
		)
	}
}
