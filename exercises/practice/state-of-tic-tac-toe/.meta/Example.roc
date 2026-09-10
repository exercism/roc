TicTacToe :: {
	board : TicTacToe.Board,
	state : TicTacToe.State,
}.{
	Cell : [O, X, Empty]
	Row : (Cell, Cell, Cell)
	Board : (Row, Row, Row)
	State : [Win, Draw, Ongoing]

	create : Board -> Try(TicTacToe, _)
	create = |board| {
		number_Xs = board |> count_cells(X)
		number_Os = board |> count_cells(O)
		if number_Xs < number_Os or number_Xs > number_Os + 1 {
			Err(InvalidBoard)
		} else {
			(last_player, other_player) = if number_Xs > number_Os {
				(X, O)
			} else {
				(O, X)
			}
			if count_full_rows(board, other_player) + count_full_cols(board, other_player) + count_full_diags(board, other_player) > 0 {
				Err(InvalidBoard)
			} else {
				full_rows = board |> count_full_rows(last_player)
				full_cols = board |> count_full_cols(last_player)
				full_diags = board |> count_full_diags(last_player)
				state = if full_rows + full_cols + full_diags > 0 {
					Win
				} else if number_Xs + number_Os == 9 {
					Draw
				} else {
					Ongoing
				}
				Ok(TicTacToe.{ board, state })
			}
		}
	}

	state : TicTacToe -> State
	state = |tic_tac_toe| {
		tic_tac_toe.state
	}
}

count_cells : TicTacToe.Board, TicTacToe.Cell -> U64
count_cells = |(row1, row2, row3), cell| {
	[row1, row2, row3].map(|row| row |> count_row_cells(cell)).sum()
}

count_row_cells : TicTacToe.Row, TicTacToe.Cell -> U64
count_row_cells = |(cell1, cell2, cell3), cell| {
	[cell1, cell2, cell3].count_if(|c| c == cell)
}

count_full_rows : TicTacToe.Board, TicTacToe.Cell -> U64
count_full_rows = |(row1, row2, row3), cell| {
	[row1, row2, row3].map(|row| row |> count_row_cells(cell)).count_if(|count| count == 3)
}

transpose : TicTacToe.Board -> TicTacToe.Board
transpose = |((c11, c12, c13), (c21, c22, c23), (c31, c32, c33))| {
	((c11, c21, c31), (c12, c22, c32), (c13, c23, c33))
}

count_full_cols : TicTacToe.Board, TicTacToe.Cell -> U64
count_full_cols = |board, cell| {
	board |> transpose |> count_full_rows(cell)
}

count_full_diags : TicTacToe.Board, TicTacToe.Cell -> U64
count_full_diags = |((c11, _, c13), (_, c22, _), (c31, _, c33)), cell| {
	diag1 = if (c11 == cell and c22 == cell and c33 == cell) {
		1
	} else {
		0
	}
	diag2 = if (c13 == cell and c22 == cell and c31 == cell) {
		1
	} else {
		0
	}
	diag1 + diag2
}
