SaddlePoints :: {}.{
	Forest : List(List(U8))
	Position : { row : U64, column : U64 }

	saddle_points : Forest -> Set(Position)
	saddle_points = |tree_heights| {
		tallest_trees_east_west : Set(Position)
		tallest_trees_east_west = {
			tree_heights
				.map_with_index(
					|row, row_index| {
						max_in_row : U8
						max_in_row = row.max() ?? 0.U8
						row.map_with_index(
							|height, column_index| {
								if height == max_in_row
									[{ row: row_index + 1, column: column_index + 1 }]
								else
									[]
							},
						)
							->join_map(|id| id) # TODO: replace with .join() when available
					},
				)
				->join_map(|id2| id2) # TODO: replace with .join() when available
				->Set.from_list()
		}

		num_columns : U64
		num_columns = tree_heights.map(List.len).max() ?? 0

		smallest_trees_north_south : Set(Position)
		smallest_trees_north_south = 
			(0..<num_columns)
				->join_map(
					|column_index| {
						column : List({ height : U8, row_index : U64 })
						column = 
							tree_heights
								.map_with_index(
									|row, row_index| {
										height = row.get(column_index)?
										Ok({ height, row_index })
									},
								)
								->keep_oks(|id| id)

						min_in_column : U8
						min_in_column = column.map(|c| c.height).min() ?? 0.U8
						column
							.keep_if(|{ height, row_index: _ }| height == min_in_column)
							.map(|{ height: _, row_index }| { row: row_index + 1, column: column_index + 1 })
					},
				)
				->Set.from_list()

		tallest_trees_east_west.intersection(smallest_trees_north_south)
	}
}

# The following functions should soon be available in Roc's builtins
join_map : i, (a -> j) -> List(b) where [i.iter : i -> Iter(a), j.iter : j -> Iter(b)]
join_map = |list, func| {
	var $state = []
	for item in list {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}

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
