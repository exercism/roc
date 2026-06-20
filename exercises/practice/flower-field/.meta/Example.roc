FlowerField :: {}.{
	annotate : Str -> Str
	annotate = |garden| {
		rows = garden.to_utf8().split_on('\n')
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

		annotated.map(
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

count_neighbors : List(List(U8)), U64, U64 -> U8
count_neighbors = |rows, x, y| {
	[-1, 0, 1].map(
		|dy| {
			[-1, 0, 1].map(
				|dx| {
					nx = dx + (
						x.to_i64_try() ?? {
							crash "Unreachable"
						},
					)
					ny = dy + (
						y.to_i64_try() ?? {
							crash "Unreachable"
						},
					)
					if is_flower(rows, nx, ny) 1 else 0
				},
			)
				.sum()
		},
	)
		.sum()
}

is_flower : List(List(U8)), I64, I64 -> Bool
is_flower = |rows, nx, ny| {
	if nx < 0 or ny < 0 {
		Bool.False
	} else {
		x = nx.to_u64_try() ?? {
			crash "Unreachable"
		}
		y = ny.to_u64_try() ?? {
			crash "Unreachable"
		}
		row = rows.get(y) ?? []
		cell = row.get(x) ?? ' '
		cell == '*'
	}
}
