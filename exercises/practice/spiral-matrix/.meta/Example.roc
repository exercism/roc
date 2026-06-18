SpiralMatrix :: {}.{
	spiral_matrix : U64 -> List(List(U64))
	spiral_matrix = |size| {
		zero_matrix = List.repeat(List.repeat(0, size), size)
		(1..=(size * size))
			.fold(
				{ x: -1, y: 0, dx: 1, dy: 0, matrix: zero_matrix },
				|state, index| {
					get_value : I64, I64 -> Try(U64, _)
					get_value = |x_i64, y_i64| {
						row = state.matrix.get(y_i64.to_u64_try()?)?
						row.get(x_i64.to_u64_try()?)
					}

					(dx, dy) = {
						(nx, ny) = (state.x + state.dx, state.y + state.dy)
						if nx < 0 or ny < 0 or get_value(nx, ny) != Ok(0) {
							(-state.dy, state.dx)
						} else {
							(state.dx, state.dy)
						}
					}

					(x, y) = (state.x + dx, state.y + dy)
					matrix = 
						state.matrix
							.update(
								y.to_u64_try() ?? {
									crash "Unreachable"
								},
								|row| {
									row.update(
										x.to_u64_try() ?? {
											crash "Unreachable"
										},
										|_| index,
									) ?? {
										crash "Unreachable"
									}
								},
							) ?? {
							crash "Unreachable"
						}
					{ x, y, dx, dy, matrix }
				},
			)
			.matrix
	}
}
