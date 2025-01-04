module [diamond]

get_char : I8, I8, I8 -> U8
get_char = \row_index, col_index, letter_index ->
    if Num.abs row_index + Num.abs col_index == letter_index then
        letter_index - Num.abs row_index |> Num.toU8 |> Num.add 'A'
    else
        ' '

unwrap_from_utf8 : List U8 -> Str
unwrap_from_utf8 = \chars ->
    when chars |> Str.fromUtf8 is
        Ok result -> result
        Err _ -> crash "Str.fromUtf8 should never fail here"

diamond : U8 -> Str
diamond = \letter ->
    letter_index = letter - 'A' |> Num.toI8
    List.range { start: At -letter_index, end: At letter_index }
    |> List.map \row_index ->
        List.range { start: At -letter_index, end: At letter_index }
        |> List.map \col_index -> get_char row_index col_index letter_index
        |> unwrap_from_utf8
    |> Str.joinWith "\n"