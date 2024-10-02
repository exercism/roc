module [parse]

parseNibble = \char ->
    if char >= '0' && char <= '9' then
        Ok (char - '0' |> Num.toU64)
    else if char >= 'A' && char <= 'F' then
        Ok (char - 'A' + 10 |> Num.toU64)
    else if char >= 'a' && char <= 'f' then
        Ok (char - 'a' + 10 |> Num.toU64)
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
            nibble = parseNibble? char
            if number > 0xfffffffffffffff then
                Err InvalidNumStr
            else
                number |> Num.shiftLeftBy 4 |> Num.add nibble |> Ok
