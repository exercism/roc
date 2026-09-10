GameOfLife :: {}.{
	State : [Dead, Alive]

	tick : List(List(State)) -> List(List(State))
	tick = |matrix| {
		matrix
			|> map(
				|{ matrix: inner_matrix, state, x, y }| {
					count = inner_matrix |> count_alive_neighbors({ x, y })
					if (state == Alive and (count == 2 or count == 3)) or (state == Dead and count == 3) {
						Alive
					} else {
						Dead
					}
				},
			)
	}
}

count_alive_neighbors : List(List(State)), { x : U64, y : U64 } -> U8
count_alive_neighbors = |matrix, { x, y }| {
	var $count = 0
	for i in ((x.minus_saturated(1))..=(x + 1)).iter() {
		for j in ((y.minus_saturated(1))..=(y + 1)).iter() {
			if (i != x or j != y) and ((matrix.get(j) ?? []).get(i) ?? Dead) == Alive {
				$count = $count + 1
			}
		}
	}
	$count
}

map : List(List(State)), ({ matrix : List(List(State)), state : State, x : U64, y : U64 } -> a) -> List(List(a))
map = |matrix, func| {
	matrix.map_with_index(
		|row, y| {
			row.map_with_index(
				|state, x| {
					func({ matrix, state, x, y })
				},
			)
		},
	)
}
