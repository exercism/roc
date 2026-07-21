Minesweeper :: {}.{
	annotate : Str -> Str
	annotate = |minefield| {
		rows = minefield.to_utf8().split_on('\n')
		annotated = 
			rows.map_with_index(
				|row, y| {
					row.map_with_index(
						|cell, x| {
							if cell == '*' {
								'*'
							} else {
								match count_neighbors(rows, x, y) {
									0 => ' '
									n => '0' + n
								}
							}
						},
					)
						->Str.from_utf8()
				},
			)

		annotated
			.map(
				|maybe_row| {
					match maybe_row {
						Ok(row) => row
						Err(_) => {
							crash "Unreachable"
						}
					}
				},
			)
			->Str.join_with("\n")
	}
}

is_bomb : List(List(U8)), I64, I64 -> Try(Bool, [OutOfBounds])
is_bomb = |rows, nx, ny| {
	if nx < 0 or ny < 0 {
		Err(OutOfBounds)
	} else {
		x = nx.to_u64_try() ?? 0
		y = ny.to_u64_try() ?? 0
		row = rows.get(y)?
		cell = row.get(x)?
		Ok(cell == '*')
	}
}

count_neighbors : List(List(U8)), U64, U64 -> U8
count_neighbors = |rows, x, y| {
	[-1, 0, 1]
		.map(
			|dy| {
				[-1, 0, 1]
					.map(
						|dx| {
							match is_bomb(rows, ((x.to_i64_try() ?? 0) + dx), ((y.to_i64_try() ?? 0) + dy)) {
								Ok(bomb) => if bomb {
									1
								} else {
									0
								}
								Err(OutOfBounds) => 0
							}
						},
					)
					.sum()
			},
		)
		.sum()
}
