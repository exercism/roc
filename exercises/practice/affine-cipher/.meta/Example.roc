module [encode, decode]

alphabetSize : U64
alphabetSize = 26

groupLength : U64
groupLength = 5

encode : Str, { a : U64, b : U64 } -> Result Str [InvalidKey, BadUtf8 _ _]
encode = \phrase, key ->
    alphabet = encodedAlphabet? key
    phrase
    |> Str.toUtf8
    |> List.joinMap \char ->
        if char >= '0' && char <= '9' then
            [char]
            else

        charLower = if char >= 'A' && char <= 'Z' then char - 'A' + 'a' else char
        if charLower >= 'a' && charLower <= 'z' then
            index = charLower - 'a' |> Num.toU64
            when alphabet |> List.get index is
                Ok encodedChar -> [encodedChar]
                Err OutOfBounds -> crash "Unreachable: index cannot be out of bounds here"
        else
            []
    |> List.chunksOf groupLength
    |> List.intersperse [' ']
    |> List.join
    |> Str.fromUtf8

encodedAlphabet : { a : U64, b : U64 } -> Result (List U8) [InvalidKey]
encodedAlphabet = \{ a, b } ->
    encoded =
        List.range { start: At 'a', end: At 'z' }
        |> List.map \char ->
            num = (char - 'a') |> Num.toU64
            index = (a * num + b) % alphabetSize
            'a' + Num.toU8 index
    if (encoded |> Set.fromList |> Set.len) < alphabetSize then
        Err InvalidKey
    else
        Ok encoded

decodedAlphabet : { a : U64, b : U64 } -> Result (List U8) [InvalidKey]
decodedAlphabet = \key ->
    encodedAlphabet? key
        |> List.mapWithIndex \encoded, decodedIndex -> { encoded, decodedIndex }
        |> List.sortWith \{ encoded: encoded1 }, { encoded: encoded2 } ->
            Num.compare encoded1 encoded2
        |> List.map \pair -> Num.toU8 pair.decodedIndex + 'a'
        |> Ok

decode : Str, { a : U64, b : U64 } -> Result Str [InvalidKey, BadUtf8 _ _, InvalidCharacter]
decode = \phrase, key ->
    alphabet = decodedAlphabet? key
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
                    Ok decodedChar -> Ok [decodedChar]
                    Err OutOfBounds -> crash "Unreachable: index cannot be out of bounds here"
            else
                Err InvalidCharacter
        |> List.join
        |> Str.fromUtf8
