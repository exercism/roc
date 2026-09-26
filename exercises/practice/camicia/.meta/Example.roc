##
## Example solution
##

Camicia :: {}.{
	Card :: U64.{

		## This function parses a Str to a Card at compile time
		from_quote : Str -> Try(Card, [BadQuotedBytes(Str)])
		from_quote = |card_str| {
			match card_str {
				"2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | "10" => Ok(Card.(0))
				"J" => Ok(Card.(1))
				"Q" => Ok(Card.(2))
				"K" => Ok(Card.(3))
				"A" => Ok(Card.(4))
				_ => Err(BadQuotedBytes(card_str))
			}
		}
	}

	GameOutcome : {
		status : [Finished, Loop],
		cards : U64,
		tricks : U64,
	}

	simulate_game : { player_a : List(Card), player_b : List(Card) } -> GameOutcome
	simulate_game = |{ player_a, player_b }| {
		state = GameState.{
			current: player_a.map(|Card.(penalty)| penalty),
			other: player_b.map(|Card.(penalty)| penalty),
			a_turn: Bool.True,
			pile: [],
			penalty: 0,
			seen: Set.empty(),
			cards: 0,
			tricks: 0,
		}
		state.play_game()
	}
}

GameState :: {
	current : List(U64),
	other : List(U64),
	a_turn : Bool,
	pile : List(U64),
	penalty : U64,
	seen : Set((List(U64), List(U64))),
	cards : U64,
	tricks : U64,
}.{
	play_game : GameState -> Camicia.GameOutcome
	play_game = |state| {
		decks = if state.a_turn {
			(state.current, state.other)
		} else {
			(state.other, state.current)
		}
		if state.current.is_empty() or state.other.is_empty() {
			{ status: Finished, cards: state.cards, tricks: state.tricks }
		} else if state.seen.contains(decks) {
			{ status: Loop, cards: state.cards, tricks: state.tricks }
		} else {
			next = { ..state, seen: state.seen.insert(decks) }
			next.play_trick().play_game()
		}
	}

	play_trick : GameState -> GameState
	play_trick = |state| {
		match state.current {
			[] => state.collect_pile()
			[card, .. as rest] => {
				changes_turn = card > 0 or state.penalty == 0
				after_play = {
					..state,
					current: rest,
					pile: state.pile.append(card),
					cards: state.cards + 1,
					penalty: if changes_turn {
						card
					} else {
						state.penalty - 1
					},
				}
				if changes_turn {
					after_play.switch_turn().play_trick()
				} else if after_play.penalty == 0 {
					after_play.collect_pile()
				} else {
					after_play.play_trick()
				}
			}
		}
	}

	switch_turn : GameState -> GameState
	switch_turn = |state| {
		{ ..state, current: state.other, other: state.current, a_turn: !state.a_turn }
	}

	collect_pile : GameState -> GameState
	collect_pile = |state| {
		winner = state.switch_turn()
		{
			..winner,
			current: winner.current.concat(winner.pile),
			pile: [],
			penalty: 0,
			tricks: winner.tricks + 1,
		}
	}
}
