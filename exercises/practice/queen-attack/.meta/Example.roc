ChessSquare :: { row : U8, column : U8 }.{
	rank : ChessSquare -> U8
	rank = |{ row, column: _ }| row + 1

	file : ChessSquare -> U8
	file = |{ row: _, column }| column + 'A'

	create : Str -> Try(ChessSquare, [InvalidSquare])
	create = |square_str| {
		chars = square_str.to_utf8()
		if chars.len() != 2 {
			Err(InvalidSquare)
		} else {
			file_char = chars.get(0).map_err(|OutOfBounds| InvalidSquare)?
			rank_char = chars.get(1).map_err(|OutOfBounds| InvalidSquare)?
			if file_char < 'A' or file_char > 'H' or rank_char < '1' or rank_char > '8' {
				Err(InvalidSquare)
			} else {
				Ok({ row: rank_char - '1', column: file_char - 'A' })
			}
		}
	}

	queen_can_attack : ChessSquare, ChessSquare -> Bool
	queen_can_attack = |{ row: r1, column: c1 }, { row: r2, column: c2 }| {
		abs_diff = |u, v| {
			if u < v {
				v - u
			} else {
				u - v
			}
		}
		rank_diff = abs_diff(r1, r2)
		file_diff = abs_diff(c1, c2)
		rank_diff == 0 or file_diff == 0 or rank_diff == file_diff
	}
}
