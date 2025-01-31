module [row, column]

parse_row : Str -> Result (List I64) [InvalidNumStr]
parse_row = |row_str|
    row_str
    |> Str.trim
    |> Str.split_on(" ")
    |> List.map(Str.trim)
    |> List.drop_if(Str.is_empty)
    |> List.map_try(Str.to_i64)

parse_matrix : Str -> Result (List (List I64)) [InvalidNumStr]
parse_matrix = |matrix_str|
    matrix_str
    |> Str.split_on("\n")
    |> List.map_try(parse_row)

column : Str, U64 -> Result (List I64) [InvalidNumStr, OutOfBounds]
column = |matrix_str, index|
    if index == 0 then
        Err(OutOfBounds)
    else
        matrix = parse_matrix(matrix_str)?
        matrix |> List.map_try(|r| r |> List.get((index - 1)))

row : Str, U64 -> Result (List I64) [InvalidNumStr, OutOfBounds]
row = |matrix_str, index|
    if index == 0 then
        Err(OutOfBounds)
    else
        matrix = parse_matrix(matrix_str)?
        result = matrix |> List.get(index - 1)?
        Ok(result)
