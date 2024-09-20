module [row, column]

parseRow : Str -> Result (List I64) [InvalidNumStr]
parseRow = \rowStr ->
    rowStr
    |> Str.trim
    |> Str.split " "
    |> List.map Str.trim
    |> List.dropIf Str.isEmpty
    |> List.mapTry Str.toI64

parseMatrix : Str -> Result (List (List I64)) [InvalidNumStr]
parseMatrix = \matrixStr ->
    matrixStr
    |> Str.trim
    |> Str.split "\n"
    |> List.mapTry parseRow

column : Str, U64 -> Result (List I64) [InvalidNumStr, OutOfBounds]
column = \matrixStr, index ->
    if index == 0 then
        Err OutOfBounds
    else
        matrix = parseMatrix? matrixStr
        matrix |> List.mapTry \r -> r |> List.get (index - 1)

row : Str, U64 -> Result (List I64) [InvalidNumStr, OutOfBounds]
row = \matrixStr, index ->
    if index == 0 then
        Err OutOfBounds
    else
        matrix = parseMatrix? matrixStr
        result = matrix |> List.get? (index - 1)
        Ok result
