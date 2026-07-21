GoCounting :: {}.{
	territory : Str, Intersection -> Try(Territory, [OutOfBounds, BoardWasEmpty, BoardWasNotRectangular, InvalidChar(U8), ..])
	territory = |board_str, intersection| {
		board = parse(board_str)?
		if intersection.x >= board.width or intersection.y >= board.height {
			Err(OutOfBounds)
		} else {
			Ok(search_territory(board, intersection))
		}
	}

	territories : Str -> Try(Territories, [BoardWasEmpty, BoardWasNotRectangular, InvalidChar(U8), ..])
	territories = |board_str| {
		board = parse(board_str)?
		empty_intersections = {
			board.rows
				.map_with_index(
					|row, y| {
						row.map_with_index(
							|stone, x| {
								if stone == None [{ x, y }] else []
							},
						)
							->join()
					},
				)
				->join()
		}
		empty_intersections.fold(
			{ black: Set.empty(), white: Set.empty(), none: Set.empty() },
			|state, intersection| {
				if state.black.contains(intersection) or state.white.contains(intersection) or state.none.contains(intersection) {
					state
				} else {
					new_territory = search_territory(board, intersection)
					match new_territory.owner {
						Black => { ..state, black: state.black.union(new_territory.territory) }
						White => { ..state, white: state.white.union(new_territory.territory) }
						None => { ..state, none: state.none.union(new_territory.territory) }
					}
				}
			},
		)
			->Ok()
	}
}

Intersection : { x : U64, y : U64 }

Stone : [White, Black, None]

Territory : {
	owner : Stone,
	territory : Set(Intersection),
}

Territories : {
	black : Set(Intersection),
	white : Set(Intersection),
	none : Set(Intersection),
}

Board : {
	rows : List(List(Stone)),
	width : U64,
	height : U64,
}

parse : Str -> Try(Board, [BoardWasEmpty, BoardWasNotRectangular, InvalidChar(U8), ..])
parse = |board_str| {
	if board_str == "" {
		Err(BoardWasEmpty)
	} else {
		rows = 
			board_str
				.to_utf8()
				.split_on('\n')
				->map_try(
					|row| {
						row->map_try(
							|char| {
								match char {
									'B' => Ok(Black)
									'W' => Ok(White)
									' ' => Ok(None)
									_ => Err(InvalidChar(char))
								}
							},
						)
					},
				)?
		row_widths = rows.map(List.len)
		width = row_widths.max() ?? 0
		if row_widths.any(|w| w != width) {
			Err(BoardWasNotRectangular)
		} else {
			height = rows.len()
			Ok({ rows, width, height })
		}
	}
}

get_stone : Board, Intersection -> Stone
get_stone = |board, { x, y }| {
	(board.rows.get(y) ?? []).get(x) ?? None
}

search_territory : Board, Intersection -> Territory
search_territory = |board, intersection| {
	help = |to_visit, visited, surrounding_stones| {
		match to_visit {
			[] => { visited, surrounding_stones }
			[visiting, .. as rest_to_visit] => {
				if visited.contains(visiting) {
					help(rest_to_visit, visited, surrounding_stones)
				} else {
					stone = get_stone(board, visiting)
					match stone {
						Black | White => {
							new_surrounding_stones = surrounding_stones.insert(stone)
							help(rest_to_visit, visited, new_surrounding_stones)
						}

						None => {
							neighbors = 
								[
									{
										x: (
											if visiting.x > 0 {
												visiting.x - 1
											} else 0,
										),
										y: visiting.y,
									},
									{ x: visiting.x + 1, y: visiting.y },
									{
										x: visiting.x,
										y: (
											if visiting.y > 0 {
												visiting.y - 1
											} else 0,
										),
									},
									{ x: visiting.x, y: visiting.y + 1 },
								]
									.drop_if(
										|neighbor| {
											neighbor.x >= board.width or neighbor.y >= board.height or neighbor == visiting
										},
									)
							new_to_visit = rest_to_visit.concat(neighbors)
							new_visited = visited.insert(visiting)
							help(new_to_visit, new_visited, surrounding_stones)
						}
					}
				}
			}
		}
	}
	search_result = help([intersection], Set.empty(), Set.empty())
	if search_result.visited.is_empty() {
		{ owner: None, territory: Set.empty() }
	} else {
		owner = 
			if search_result.surrounding_stones == Set.from_list([Black]) {
				Black
			} else if search_result.surrounding_stones == Set.from_list([White]) {
				White
			} else {
				None
			}
		{ owner, territory: search_result.visited }
	}
}

# The following function should soon be available in Roc's builtins
join = |list| {
	var $state = []
	for sublist in list {
		for item in sublist {
			$state = $state.append(item)
		}
	}
	$state
}

map_try = |list, func| {
	var $state = []
	for item in list {
		$state = $state.append(func(item)?)
	}
	Ok($state)
}