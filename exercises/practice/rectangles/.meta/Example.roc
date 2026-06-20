Rectangles :: {}.{
	rectangles : Str -> U64
	rectangles = |diagram| {
		grid = 
			diagram
				.split_on("\n")
				.map(|s| s.to_utf8())
		height = grid.len()
		grid
			.map_with_index(
				|row, y1| {
					row
						.map_with_index(
							|_char, x1| {
								y2s = ((y1 + 1)..<height).fold([], |acc, y| acc.append(y))
								y2s
									.map(
										|y2| {
											x2s = ((x1 + 1)..<row.len()).fold([], |acc, x| acc.append(x))
											x2s
												.map(
													|x2| {
														if is_rectangle({ grid, x1, y1, x2, y2 }) {
															1
														} else {
															0
														}
													},
												)
												.sum()
										},
									)
									.sum()
							},
						)
						.sum()
				},
			)
			.sum()
	}
}

is_rectangle : { grid : List(List(U8)), x1 : U64, y1 : U64, x2 : U64, y2 : U64 } -> Bool
is_rectangle = |{ grid, x1, y1, x2, y2 }| {
	get_cell = |pos| {
		(x, y) = pos
		grid.get(y)?.get(x)
	}

	is_corner = |pos| {
		get_cell(pos) == Ok('+')
	}
	is_horizontal = |pos| {
		is_corner(pos) or get_cell(pos) == Ok('-')
	}
	is_vertical = |pos| {
		is_corner(pos) or get_cell(pos) == Ok('|')
	}

	has_horizontal_border = |y| {
		xs = (x1..=x2).fold([], |acc, x| acc.append(x))
		xs.all(|x| is_horizontal((x, y)))
	}

	has_vertical_border = |x| {
		ys = (y1..=y2).fold([], |acc, y| acc.append(y))
		ys.all(|y| is_vertical((x, y)))
	}

	(
		[(x1, y1), (x2, y1), (x1, y2), (x2, y2)].all(is_corner)
			and [y1, y2].all(has_horizontal_border)
				and [x1, x2].all(has_vertical_border),
	)
}
