Camicia :: {}.{
	Card :: {
		# TODO: change this opaque type however you need
		todo1 : U64,
		todo2 : U64,
		todo3 : U64,
		# etc.
	}.{

		## This function parses a Str to a Card at compile time
		from_quote : Str -> Try(Card, [BadQuotedBytes(Str)])
		from_quote = |card_str| {
			crash "Please implement the 'from_quote' function"
		}
	}

	GameOutcome : {
		status : [Finished, Loop],
		cards : U64,
		tricks : U64,
	}

	simulate_game : { player_a : List(Card), player_b : List(Card) } -> GameOutcome
	simulate_game = |{ player_a, player_b }| {
		crash "Please implement the 'simulate_game' function"
	}
}
