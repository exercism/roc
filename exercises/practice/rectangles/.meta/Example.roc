module [rectangles]

## Is there a rectangle between the top left (x1, y1) corner and the bottom
## right (x2, y2) corner.
isRectangle : { grid : List (List U8), x1 : U64, y1 : U64, x2 : U64, y2 : U64 } -> Bool
isRectangle = \{ grid, x1, y1, x2, y2 } ->
    getCell = \(x, y) -> grid |> List.get? y |> List.get x
    isCorner = \pos -> getCell pos == Ok '+'
    isHorizontal = \pos -> isCorner pos || getCell pos == Ok '-'
    isVertical = \pos -> isCorner pos || getCell pos == Ok '|'
    hasHorizontalBorder = \y ->
        List.range { start: At x1, end: At x2 }
        |> List.all \x -> isHorizontal (x, y)
    hasVerticalBorder = \x ->
        List.range { start: At y1, end: At y2 }
        |> List.all \y -> isVertical (x, y)
    (
        ([(x1, y1), (x2, y1), (x1, y2), (x2, y2)] |> List.all isCorner)
        && ([y1, y2] |> List.all hasHorizontalBorder)
        && ([x1, x2] |> List.all hasVerticalBorder)
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
                    if isRectangle { grid, x1, y1, x2, y2 } then 1 else 0
                |> List.sum
            |> List.sum
        |> List.sum
    |> List.sum
