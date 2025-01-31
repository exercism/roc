module [convert]

BadGridSize : [HeightWasNotAMultipleOf4, WidthWasNotAMultipleOf3, GridShapeWasNotRectangular]

convert : Str -> Result Str BadGridSize
convert = |grid|
    if grid == "" then
        Ok("")
    else
        grid_chars = grid |> Str.to_utf8 |> List.split_on('\n')
        size = check_size(grid_chars)?
        grid_chars
        |> List.chunks_of(4) # split vertically into groups of 4 rows
        |> List.map(
            |row_group|
                get_digit_grids(row_group, size.width)
                |> List.map(identify_digit)
                |> Str.join_with(""),
        )
        |> Str.join_with(",")
        |> Ok

check_size : List (List U8) -> Result { height : U64, width : U64 } BadGridSize
check_size = |grid_chars|
    height = List.len(grid_chars)
    if height % 4 != 0 then
        Err(HeightWasNotAMultipleOf4)
    else
        width = grid_chars |> List.map(List.len) |> List.max |> Result.with_default(0)
        if width % 3 != 0 then
            Err(WidthWasNotAMultipleOf3)
        else
            is_rectangular = grid_chars |> List.all(|row| List.len(row) == width)
            if is_rectangular then
                Ok({ height, width })
            else
                Err(GridShapeWasNotRectangular)

## Given four rows from the full grid, return the 3x4 grid for each digit
get_digit_grids : List (List U8), U64 -> List (List (List U8))
get_digit_grids = |row_group, full_grid_width|
    chunked_rows =
        row_group
        |> List.map(
            |row|
                row |> List.chunks_of(3),
        )
    num_horizontal_chunks = full_grid_width // 3
    List.range({ start: At(0), end: Before(num_horizontal_chunks) })
    |> List.map(
        |chunk_index|
            chunked_rows
            |> List.map(
                |chunked_row|
                    when chunked_row |> List.get(chunk_index) is
                        Ok(chunk) -> chunk
                        Err(OutOfBounds) -> crash("Unreachable: we checked the grid size"),
            ),
    )

identify_digit : List (List U8) -> Str
identify_digit = |digit_grid|
    #  _     _  _     _  _  _  _  _
    # | |  | _| _||_||_ |_   ||_||_|
    # |_|  ||_  _|  | _||_|  ||_| _|
    when digit_grid is
        [[' ', '_', ' '], ['|', ' ', '|'], ['|', '_', '|'], [' ', ' ', ' ']] -> "0"
        [[' ', ' ', ' '], [' ', ' ', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] -> "1"
        [[' ', '_', ' '], [' ', '_', '|'], ['|', '_', ' '], [' ', ' ', ' ']] -> "2"
        [[' ', '_', ' '], [' ', '_', '|'], [' ', '_', '|'], [' ', ' ', ' ']] -> "3"
        [[' ', ' ', ' '], ['|', '_', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] -> "4"
        [[' ', '_', ' '], ['|', '_', ' '], [' ', '_', '|'], [' ', ' ', ' ']] -> "5"
        [[' ', '_', ' '], ['|', '_', ' '], ['|', '_', '|'], [' ', ' ', ' ']] -> "6"
        [[' ', '_', ' '], [' ', ' ', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] -> "7"
        [[' ', '_', ' '], ['|', '_', '|'], ['|', '_', '|'], [' ', ' ', ' ']] -> "8"
        [[' ', '_', ' '], ['|', '_', '|'], [' ', '_', '|'], [' ', ' ', ' ']] -> "9"
        _ -> "?"
