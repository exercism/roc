module [parse]

parseNibble = \char ->
    when char is
        c if c >= '0' && c <= '9' -> Ok (c - '0' |> Num.toU64)
        c if c >= 'A' && c <= 'F' -> Ok (c - 'A' + 10 |> Num.toU64)
        c if c >= 'a' && c <= 'f' -> Ok (c - 'a' + 10 |> Num.toU64)
        _ -> Err InvalidNumStr

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
