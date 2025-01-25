module [parse]

parse_nibble = |char|
    if char >= '0' and char <= '9' then
        Ok((char - '0' |> Num.to_u64))
    else if char >= 'A' and char <= 'F' then
        Ok((char - 'A' + 10 |> Num.to_u64))
    else if char >= 'a' and char <= 'f' then
        Ok((char - 'a' + 10 |> Num.to_u64))
    else
        Err(InvalidNumStr)

parse : Str -> Result U64 _
parse = |string|
    if string == "" then
        Err(InvalidNumStr)
    else
        string
        |> Str.to_utf8
        |> List.walk_try(
            0,
            |number, char|
                nibble = parse_nibble(char)?
                if number > 0xfffffffffffffff then
                    Err(InvalidNumStr)
                else
                    number |> Num.shift_left_by(4) |> Num.add(nibble) |> Ok,
        )
