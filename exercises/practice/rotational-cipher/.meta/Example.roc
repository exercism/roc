module [rotate]

shift_char = |c, shift_key|
    if c >= 'a' and c <= 'z' then
        (c - 'a' + shift_key) % 26 + 'a'
    else if c >= 'A' and c <= 'Z' then
        (c - 'A' + shift_key) % 26 + 'A'
    else
        c

rotate : Str, U8 -> Str
rotate = |text, shift_key|
    text
    |> Str.to_utf8
    |> List.map(|c| shift_char(c, shift_key))
    |> Str.from_utf8
    |> Result.with_default("Unreachable")
