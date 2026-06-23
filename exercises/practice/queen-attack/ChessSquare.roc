ChessSquare :: {
	# TODO: change this opaque type however you need
	todo1 : U64,
	todo2 : U64,
	todo3 : U64,
	# etc.
}.{
	create : Str -> Try(ChessSquare, _)
	create = |square_str| {
		crash "Please implement the 'create' function"
	}

	rank : ChessSquare -> U8
	rank = |square| {
		crash "Please implement the 'rank' function"
	}

	file : ChessSquare -> U8
	file = |square| {
		crash "Please implement the 'file' function"
	}

	queen_can_attack : ChessSquare, ChessSquare -> Bool
	queen_can_attack = |square1, square2| {
		crash "Please implement the 'queen_can_attack' function"
	}
}
