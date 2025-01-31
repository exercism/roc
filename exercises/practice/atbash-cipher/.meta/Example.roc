module [encode, decode]

invert : U8 -> U8
invert = |char|
    if char >= 'a' and char <= 'z' then
        'z' - char + 'a'
    else
        char

encode : Str -> Result Str _
encode = |phrase|
    phrase
    |> Str.to_utf8
    |> List.join_map(
        |char|
            if char >= 'A' and char <= 'Z' then
                [invert((char - 'A' + 'a'))]
            else if char >= 'a' and char <= 'z' then
                [invert(char)]
            else if char >= '0' and char <= '9' then
                [char]
            else
                [],
    )
    |> List.chunks_of(5)
    |> List.intersperse([' '])
    |> List.join
    |> Str.from_utf8

decode : Str -> Result Str _
decode = |phrase|
    phrase
    |> Str.to_utf8
    |> List.drop_if(|c| c == ' ')
    |> List.map(invert)
    |> Str.from_utf8
