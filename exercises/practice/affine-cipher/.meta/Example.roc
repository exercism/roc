module [encode, decode]

alphabet_size : U64
alphabet_size = 26

group_length : U64
group_length = 5

encode : Str, { a : U64, b : U64 } -> Result Str [InvalidKey, BadUtf8 _ ]
encode = |phrase, key|
    alphabet = encoded_alphabet(key)?
    phrase
    |> Str.to_utf8
    |> List.join_map(
        |char|
            if char >= '0' and char <= '9' then
                [char]
            else
                char_lower = if char >= 'A' and char <= 'Z' then char - 'A' + 'a' else char
                if char_lower >= 'a' and char_lower <= 'z' then
                    index = char_lower - 'a' |> Num.to_u64
                    when alphabet |> List.get(index) is
                        Ok(encoded_char) -> [encoded_char]
                        Err(OutOfBounds) -> crash("Unreachable: index cannot be out of bounds here")
                else
                    [],
    )
    |> List.chunks_of(group_length)
    |> List.intersperse([' '])
    |> List.join
    |> Str.from_utf8

encoded_alphabet : { a : U64, b : U64 } -> Result (List U8) [InvalidKey]
encoded_alphabet = |{ a, b }|
    encoded =
        List.range({ start: At('a'), end: At('z') })
        |> List.map(
            |char|
                num = (char - 'a') |> Num.to_u64
                index = (a * num + b) % alphabet_size
                'a' + Num.to_u8(index),
        )
    if (encoded |> Set.from_list |> Set.len) < alphabet_size then
        Err(InvalidKey)
    else
        Ok(encoded)

decoded_alphabet : { a : U64, b : U64 } -> Result (List U8) [InvalidKey]
decoded_alphabet = |key|
    encoded_alphabet(key)?
    |> List.map_with_index(|encoded, decoded_index| { encoded, decoded_index })
    |> List.sort_with(
        |{ encoded: encoded1 }, { encoded: encoded2 }|
            Num.compare(encoded1, encoded2),
    )
    |> List.map(|pair| Num.to_u8(pair.decoded_index) + 'a')
    |> Ok

decode : Str, { a : U64, b : U64 } -> Result Str [InvalidKey, BadUtf8 _, InvalidCharacter]
decode = |phrase, key|
    alphabet = decoded_alphabet(key)?
    phrase
    |> Str.to_utf8
    |> List.map_try(
        |char|
            if char == ' ' then
                Ok([])
            else if char >= '0' and char <= '9' then
                Ok([char])
            else if char >= 'a' and char <= 'z' then
                index = char - 'a' |> Num.to_u64
                when alphabet |> List.get(index) is
                    Ok(decoded_char) -> Ok([decoded_char])
                    Err(OutOfBounds) -> crash("Unreachable: index cannot be out of bounds here")
            else
                Err(InvalidCharacter),
    )?
    |> List.join
    |> Str.from_utf8
