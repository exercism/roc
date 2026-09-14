TicTacToe :: {
	# TODO: change this opaque type however you need
	todo1 : U64,
	todo2 : U64,
	todo3 : U64,
	# etc.
}.{
	Cell : [O, X, Empty]
	Row : (Cell, Cell, Cell)
	Board : (Row, Row, Row)
	State : [Win, Draw, Ongoing]

	create : Board -> Try(TicTacToe, _)
	create = |board| {
		crash "Please implement the 'create' function"
	}

	state : TicTacToe -> State
	state = |tic_tac_toe| {
		crash "Please implement the 'state' function"
	}
}
