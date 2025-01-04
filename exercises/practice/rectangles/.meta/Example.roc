module [rectangles]

## Is there a rectangle between the top left (x1, y1) corner and the bottom
## right (x2, y2) corner.
is_rectangle : { grid : List (List U8), x1 : U64, y1 : U64, x2 : U64, y2 : U64 } -> Bool
is_rectangle = \{ grid, x1, y1, x2, y2 } ->
    get_cell = \(x, y) -> grid |> List.get? y |> List.get x
    is_corner = \pos -> get_cell pos == Ok '+'
    is_horizontal = \pos -> is_corner pos || get_cell pos == Ok '-'
    is_vertical = \pos -> is_corner pos || get_cell pos == Ok '|'
    has_horizontal_border = \y ->
        List.range { start: At x1, end: At x2 }
        |> List.all \x -> is_horizontal (x, y)
    has_vertical_border = \x ->
        List.range { start: At y1, end: At y2 }
        |> List.all \y -> is_vertical (x, y)
    (
        ([(x1, y1), (x2, y1), (x1, y2), (x2, y2)] |> List.all is_corner)
        && ([y1, y2] |> List.all has_horizontal_border)
        && ([x1, x2] |> List.all has_vertical_border)
    )

rectangles : Str -> U64
rectangles = \diagram ->
    grid =
        diagram
        |> Str.splitOn "\n"
        |> List.map Str.toUtf8
    height = grid |> List.len
    grid
    |> List.mapWithIndex \row, y1 -> # number of rectangles with top on this row
        row
        |> List.mapWithIndex \_char, x1 -> # number with top-left on this column
            List.range { start: After y1, end: Before height }
            |> List.map \y2 -> # number of rectangles with bottom on this row
                List.range { start: After x1, end: Before (List.len row) }
                |> List.map \x2 -> # number with bottom-right on this column
                    if is_rectangle { grid, x1, y1, x2, y2 } then 1 else 0
                |> List.sum
            |> List.sum
        |> List.sum
    |> List.sum