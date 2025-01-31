module [transpose]

## Transpose the input string. Input string must be ASCII.
transpose : Str -> Str
transpose = |string|
    chars = string |> Str.to_utf8 |> List.split_on('\n')
    get_char = |row, col|
        chars |> List.get(row)? |> List.get(col)
    max_width = chars |> List.map(List.len) |> List.max |> Result.with_default(0)
    List.range({ start: At(0), end: Before(max_width) })
    |> List.map(
        |col|
            max_row =
                chars
                |> List.find_last_index(|row_chars| List.len(row_chars) > col)
                |> Result.with_default(0)
            List.range({ start: At(0), end: At(max_row) })
            |> List.map(|row| get_char(row, col) |> Result.with_default(' '))
            |> Str.from_utf8
            |> Result.with_default(""),
    ) # unreachable because string is ASCII
    |> Str.join_with("\n")
