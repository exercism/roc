module [rotate]

shiftChar = \c, shiftKey ->
    if c >= 'a' && c <= 'z' then
        (c - 'a' + shiftKey) % 26 + 'a'
    else if c >= 'A' && c <= 'Z' then
        (c - 'A' + shiftKey) % 26 + 'A'
    else
        c

rotate = \text, shiftKey ->
    text
    |> Str.toUtf8
    |> List.map \c -> shiftChar c shiftKey
    |> Str.fromUtf8
    |> Result.withDefault "Unreachable"
