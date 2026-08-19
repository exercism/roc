SaveTheCow :: {}.{
	guess : Str, List(U8) -> Try({ outcome : [Win, Ongoing, Lose], masked_word : Str, remaining_failures : U8 }, [GameOver, ..])
	guess = |word, guesses| {
		word_chars = word.to_utf8()
		initial_state = {
			outcome: Ongoing,
			masked_word: "_".repeat(word.to_utf8().len()),
			remaining_failures: 9,
		}
		guesses.fold_try(
			initial_state,
			|state, char| {
				if state.outcome != Ongoing {
					Err(GameOver)
				} else {
					masked_chars = state.masked_word.to_utf8()
					masked_word =
						if masked_chars.contains(char) or !word_chars.contains(char) {
							state.masked_word
						} else {
							masked_chars.map2(
								word_chars,
								|m, c| {
									if m == '_' and c == char {
										c
									} else {
										m
									}
								},
							)
								|> Str.from_utf8 ?? {
								crash "Unreachable assuming the word is ASCII-only"
							}
						}
					if masked_word == state.masked_word {
						remaining_failures = state.remaining_failures.minus_saturated(1)
						outcome = if state.remaining_failures == 0 {
							Lose
						} else {
							Ongoing
						}
						Ok({ outcome, masked_word, remaining_failures })
					} else {
						outcome = if word == masked_word {
							Win
						} else {
							Ongoing
						}
						Ok({ ..state, outcome, masked_word })
					}
				}
			},
		)
	}
}
