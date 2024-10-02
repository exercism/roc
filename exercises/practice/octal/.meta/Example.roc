module [parse]

parseOctalDigit = \char ->
    if char >= '0' && char <= '7' then
        Ok (char - '0' |> Num.toU64)
    else
        Err InvalidNumStr

parse : Str -> Result U64 _
parse = \string ->
    if string == "" then
        Err InvalidNumStr
        else

    string
        |> Str.toUtf8
        |> List.walkTry 0 \number, char ->
            octalDigit = parseOctalDigit? char
            if number > 0x1fffffffffffffff then
                Err InvalidNumStr
            else
                number |> Num.shiftLeftBy 3 |> Num.add octalDigit |> Ok
