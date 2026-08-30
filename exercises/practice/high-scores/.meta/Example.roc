HighScores :: {}.{
	latest : List(U64) -> Try(U64, [ListWasEmpty])
	latest = |scores| {
		List.last(scores)
	}

	personal_best : List(U64) -> Try(U64, [ListWasEmpty])
	personal_best = |scores| {
		List.max(scores)
	}

	personal_top_three : List(U64) -> List(U64)
	personal_top_three = |scores| {
		scores.sort_reversed().take_first(3)
	}
}
