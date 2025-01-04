module [rotate]

shift_char = \c, shift_key ->
    if c >= 'a' && c <= 'z' then
        (c - 'a' + shift_key) % 26 + 'a'
    else if c >= 'A' && c <= 'Z' then
        (c - 'A' + shift_key) % 26 + 'A'
    else
        c

rotate : Str, U8 -> Str
rotate = \text, shift_key ->
    text
    |> Str.toUtf8
    |> List.map \c -> shift_char c shift_key
    |> Str.fromUtf8
    |> Result.withDefault "Unreachable"
