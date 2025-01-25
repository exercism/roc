module [parse]

parse_octal_digit = |char|
    if char >= '0' and char <= '7' then
        Ok((char - '0' |> Num.to_u64))
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
                octal_digit = parse_octal_digit(char)?
                if number > 0x1fffffffffffffff then
                    Err(InvalidNumStr)
                else
                    number |> Num.shift_left_by(3) |> Num.add(octal_digit) |> Ok,
        )
