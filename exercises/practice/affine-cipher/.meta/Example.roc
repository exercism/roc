module [encode, decode]

alphabet_size : U64
alphabet_size = 26

group_length : U64
group_length = 5

encode : Str, { a : U64, b : U64 } -> Result Str [InvalidKey, BadUtf8 _ _]
encode = \phrase, key ->
    alphabet = encoded_alphabet? key
    phrase
    |> Str.toUtf8
    |> List.joinMap \char ->
        if char >= '0' && char <= '9' then
            [char]
            else

        char_lower = if char >= 'A' && char <= 'Z' then char - 'A' + 'a' else char
        if char_lower >= 'a' && char_lower <= 'z' then
            index = char_lower - 'a' |> Num.toU64
            when alphabet |> List.get index is
                Ok encoded_char -> [encoded_char]
                Err OutOfBounds -> crash "Unreachable: index cannot be out of bounds here"
        else
            []
    |> List.chunksOf group_length
    |> List.intersperse [' ']
    |> List.join
    |> Str.fromUtf8

encoded_alphabet : { a : U64, b : U64 } -> Result (List U8) [InvalidKey]
encoded_alphabet = \{ a, b } ->
    encoded =
        List.range { start: At 'a', end: At 'z' }
        |> List.map \char ->
            num = (char - 'a') |> Num.toU64
            index = (a * num + b) % alphabet_size
            'a' + Num.toU8 index
    if (encoded |> Set.fromList |> Set.len) < alphabet_size then
        Err InvalidKey
    else
        Ok encoded

decoded_alphabet : { a : U64, b : U64 } -> Result (List U8) [InvalidKey]
decoded_alphabet = \key ->
    encoded_alphabet? key
        |> List.mapWithIndex \encoded, decoded_index -> { encoded, decoded_index }
        |> List.sortWith \{ encoded: encoded1 }, { encoded: encoded2 } ->
            Num.compare encoded1 encoded2
        |> List.map \pair -> Num.toU8 pair.decoded_index + 'a'
        |> Ok

decode : Str, { a : U64, b : U64 } -> Result Str [InvalidKey, BadUtf8 _ _, InvalidCharacter]
decode = \phrase, key ->
    alphabet = decoded_alphabet? key
    phrase
        |> Str.toUtf8
        |> List.mapTry? \char ->
            if char == ' ' then
                Ok []
            else if char >= '0' && char <= '9' then
                Ok [char]
            else if char >= 'a' && char <= 'z' then
                index = char - 'a' |> Num.toU64
                when alphabet |> List.get index is
                    Ok decoded_char -> Ok [decoded_char]
                    Err OutOfBounds -> crash "Unreachable: index cannot be out of bounds here"
            else
                Err InvalidCharacter
        |> List.join
        |> Str.fromUtf8
