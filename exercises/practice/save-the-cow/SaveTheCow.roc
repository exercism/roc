SaveTheCow :: {}.{
	guess : Str, List(U8) -> Try({ outcome : [Win, Ongoing, Lose], masked_word : Str, remaining_failures : U8 }, [GameOver, ..])
	guess = |word, guesses| {
		crash "Please implement the 'guess' function"
	}
}
