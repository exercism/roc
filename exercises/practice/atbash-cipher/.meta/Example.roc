module [encode, decode]

invert : U8 -> U8
invert = \char ->
    if char >= 'a' && char <= 'z' then
        'z' - char + 'a'
    else
        char

encode : Str -> Result Str _
encode = \phrase ->
    phrase
    |> Str.toUtf8
    |> List.joinMap \char ->
        if char >= 'A' && char <= 'Z' then
            [invert (char - 'A' + 'a')]
        else if char >= 'a' && char <= 'z' then
            [invert char]
        else if char >= '0' && char <= '9' then
            [char]
        else
            []
    |> List.chunksOf 5
    |> List.intersperse [' ']
    |> List.join
    |> Str.fromUtf8

decode : Str -> Result Str _
decode = \phrase ->
    phrase
    |> Str.toUtf8
    |> List.dropIf \c -> c == ' '
    |> List.map invert
    |> Str.fromUtf8
