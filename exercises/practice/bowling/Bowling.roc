Bowling :: {
	# TODO: change this opaque type however you need
	todo1 : U64,
	todo2 : U64,
	todo3 : U64,
	# etc.
}.{
	new : Bowling
	new = {
		crash "Please implement the 'new' constant"
	}

	roll : Bowling, U64 -> Try(Bowling, _)
	roll = |game, pins| {
		crash "Please implement the 'roll' function"
	}

	score : Bowling -> Try(U64, _)
	score = |game| {
		crash "Please implement the 'score' function"
	}
}
