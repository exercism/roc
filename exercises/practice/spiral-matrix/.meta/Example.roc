module [spiral_matrix]

spiral_matrix : U64 -> List (List U64)
spiral_matrix = |size|
    zero_matrix = List.repeat(List.repeat(0, size), size)
    List.range({ start: At(1), end: At((size * size)) })
    |> List.walk(
        { x: -1, y: 0, dx: 1, dy: 0, matrix: zero_matrix },
        |state, index|
            get_value = |x_i64, y_i64|
                row = state.matrix |> List.get(Num.to_u64(y_i64)) |> Result.with_default([])
                row |> List.get(Num.to_u64(x_i64))

            (dx, dy) =
                (nx, ny) = (state.x + state.dx, state.y + state.dy)
                if nx < 0 or ny < 0 or get_value(nx, ny) != Ok(0) then
                    (-state.dy, state.dx) # outside or non-zero value => turn right
                else
                    (state.dx, state.dy) # or else continue in the same direction

            (x, y) = (state.x + dx, state.y + dy)
            matrix =
                state.matrix
                |> List.update(
                    (y |> Num.to_u64),
                    |row|
                        row |> List.update((x |> Num.to_u64), |_| index),
                )
            { x, y, dx, dy, matrix },
    )
    |> .matrix
