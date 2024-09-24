module [decimal]

decimal : Str -> Result U64 [InvalidCharacter U8]
decimal = \binaryStr ->
    binaryStr
        |> Str.toUtf8
        |> List.mapTry? \char ->
            when char is
                '0' -> Ok 0
                '1' -> Ok 1
                c -> Err (InvalidCharacter c)
        |> List.walk 0 \dec, bit ->
            dec * 2 + bit
        |> Ok
