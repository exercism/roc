module [transpose]

## Transpose the input string. Input string must be ASCII.
transpose : Str -> Str
transpose = \string ->
    chars =
        string
        |> Str.split "\n"
        |> List.map \row -> row |> Str.toUtf8
    getChar = \row, col ->
        chars |> List.get? row |> List.get col
    maxWidth = chars |> List.map List.len |> List.max |> Result.withDefault 0
    List.range { start: At 0, end: Before maxWidth }
    |> List.map \col ->
        maxRow =
            chars
            |> List.findLastIndex \rowChars -> List.len rowChars > col
            |> Result.withDefault 0
        List.range { start: At 0, end: At maxRow }
        |> List.map \row -> getChar row col |> Result.withDefault ' '
        |> Str.fromUtf8
        |> Result.withDefault "" # unreachable because string is ASCII
    |> Str.joinWith "\n"
