module [row, column]

parse_row : Str -> Result (List I64) [InvalidNumStr]
parse_row = \row_str ->
    row_str
    |> Str.trim
    |> Str.splitOn " "
    |> List.map Str.trim
    |> List.dropIf Str.isEmpty
    |> List.mapTry Str.toI64

parse_matrix : Str -> Result (List (List I64)) [InvalidNumStr]
parse_matrix = \matrix_str ->
    matrix_str
    |> Str.splitOn "\n"
    |> List.mapTry parse_row

column : Str, U64 -> Result (List I64) [InvalidNumStr, OutOfBounds]
column = \matrix_str, index ->
    if index == 0 then
        Err OutOfBounds
    else
        matrix = parse_matrix? matrix_str
        matrix |> List.mapTry \r -> r |> List.get (index - 1)

row : Str, U64 -> Result (List I64) [InvalidNumStr, OutOfBounds]
row = \matrix_str, index ->
    if index == 0 then
        Err OutOfBounds
    else
        matrix = parse_matrix? matrix_str
        result = matrix |> List.get? (index - 1)
        Ok result