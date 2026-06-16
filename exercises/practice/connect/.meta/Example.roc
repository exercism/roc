Connect :: {}.{
	winner : Str -> Try([PlayerO, PlayerX], [NotFinished, InvalidCharacter(U8), InvalidBoardShape, ..])
	winner = |board_str| {
		board = parse(board_str)?
		_ = validate(board)?
		if board->has_north_south_path(StoneO) {
			Ok(PlayerO)
		} else if board->transpose()->has_north_south_path(StoneX) {
			Ok(PlayerX)
		} else {
			Err(NotFinished)
		}
	}
}

Cell := [StoneO, StoneX, Empty]

Board : List(List(Cell))

Position : { x : U64, y : U64 }

# # Parse a string to a Board
parse : Str -> Try(Board, [InvalidCharacter(U8), ..])
parse = |board_str| {
	board_str
		.trim()
		.to_utf8()
		.split_on(
			'\n',
		)
		->map_try(
			|row| {
				row
					.drop_if(
						|char| char == ' ',
					)
					->map_try(
						|char| {
							match char {
								'O' => Ok(StoneO)
								'X' => Ok(StoneX)
								'.' => Ok(Empty)
								_ => Err(InvalidCharacter(char))
							}
						},
					)
			},
		)
}

# # Ensure that the board has a least one cell, and that all rows have the same length
validate : Board -> Try({}, [InvalidBoardShape, ..])
validate = |board| {
	row_lengths = board.map(List.len)->Set.from_list()
	if row_lengths.len() != 1 or row_lengths == Set.from_list([0]) {
		Err(InvalidBoardShape)
	} else {
		Ok({})
	}
}

transpose : Board -> Board
transpose = |board| {
	width = (board->first_row()).len()
	(0..<width)
		.map(
			|x| {
				(0..<board.len())
					.map(
						|y| {
							match board->get_cell({ x, y }) {
								Ok(cell) => cell
								Err(OutOfBounds) => {
									crash "Unreachable: all rows have the same length"
								}
							}
						},
					)
					->List.from_iter()
			},
		)
		->List.from_iter()
}

first_row : Board -> List(Cell)
first_row = |board| {
	match board.first() {
		Ok(row) => row
		Err(ListWasEmpty) => {
			crash "Unreachable: the board has at least one cell"
		}
	}
}

get_cell : Board, Position -> Try(Cell, [OutOfBounds, ..])
get_cell = |board, { x, y }| {
	board.get(y)?.get(x)
}

has_north_south_path : Board, Cell -> Bool
has_north_south_path = |board, stone| {
	has_path_to_south : List(Position), Set(Position) -> Bool
	has_path_to_south = |to_visit, visited| {
		match to_visit {
			[] => Bool.False
			[position, .. as rest] => {
				is_player_stone = board->get_cell(position) == Ok(stone)
				if is_player_stone and !(visited.contains(position)) {
					{ x, y } = position
					if y + 1 == board.len() {
						Bool.True # we've reached the South!
					} else {
						neighbors = {
							[(-1, 0), (1, 0), (0, -1), (1, -1), (-1, 1), (0, 1)]
								->join_map(
									|(dx, dy)| {
										nx = (
											x.to_i64_try() ?? {
												crash "Unreachable"
											},
										) + dx
										ny = (
											y.to_i64_try() ?? {
												crash "Unreachable"
											},
										) + dy
										if nx >= 0 and ny >= 0 {
											[
												{
													x: nx.to_u64_try() ?? {
														crash "Unreachable"
													},
													y: ny.to_u64_try() ?? {
														crash "Unreachable"
													},
												},
											]
										} else {
											[]
										}
									},
								)
						}
						has_path_to_south((rest.concat(neighbors)), (visited.insert(position)))
					}
				} else {
					has_path_to_south(rest, visited)
				}
			}
		}
	}

	north_stones : List(Position)
	north_stones = {
		board
			->first_row()
			.map_with_index(
				|cell, x| {
					match cell {
						StoneO | StoneX => if cell == stone Ok({ x, y: 0 }) else Err(NotPlayerStone)
						Empty => Err(NotPlayerStone)
					}
				},
			)
			->keep_oks(|id| id)
	}
	has_path_to_south(north_stones, Set.empty())
}

# The following functions should soon be available in Roc's builtins
keep_oks = |iter, func| {
	iter
		->join_map(
			|item| {
				match func(item) {
					Ok(result) => [result]
					Err(_) => []
				}
			},
		)
}

join_map = |iter, func| {
	var $state = []
	for item in iter {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}

map_try = |iter, func| {
	var $state = []
	for item in iter {
		$state = $state.append(func(item)?)
	}
	Ok($state)
}
