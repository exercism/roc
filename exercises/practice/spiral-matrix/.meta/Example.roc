module [spiralMatrix]

spiralMatrix : U64 -> List (List U64)
spiralMatrix = \size ->
    zeroMatrix = List.repeat (List.repeat 0 size) size
    List.range { start: At 1, end: At (size * size) }
    |> List.walk { x: -1, y: 0, dx: 1, dy: 0, matrix: zeroMatrix } \state, index ->
        getValue = \xI64, yI64 ->
            row = state.matrix |> List.get (Num.toU64 yI64) |> Result.withDefault []
            row |> List.get (Num.toU64 xI64)

        (dx, dy) =
            (nx, ny) = (state.x + state.dx, state.y + state.dy)
            if nx < 0 || ny < 0 || getValue nx ny != Ok 0 then
                (-state.dy, state.dx) # outside or non-zero value => turn right
            else
                (state.dx, state.dy) # or else continue in the same direction

        (x, y) = (state.x + dx, state.y + dy)
        matrix =
            state.matrix
            |> List.update (y |> Num.toU64) \row ->
                row |> List.update (x |> Num.toU64) \_ -> index
        { x, y, dx, dy, matrix }
    |> .matrix
