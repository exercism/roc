module [clean]

clean : Str -> Result Str [InvalidNumber]
clean = |phone_number|
    digits =
        phone_number
        |> Str.to_utf8
        |> List.keep_if(|c| c >= '0' and c <= '9')

    num_digits = List.len(digits)
    if num_digits == 10 then
        digits |> check_number
    else if num_digits == 11 then
        when digits is
            ['1', .. as rest] -> rest |> check_number
            _ -> Err(InvalidNumber) # only country code 1 is supported
    else
        Err(InvalidNumber)

check_number : List U8 -> Result Str [InvalidNumber]
check_number = |digits|
    when digits is
        [a1, _, _, e1, ..] if a1 == '0' or a1 == '1' or e1 == '0' or e1 == '1' ->
            Err(InvalidNumber) # area code and exchange must not start with 0 or 1

        _ ->
            when digits |> Str.from_utf8 is
                Ok(number) -> Ok(number)
                Err(BadUtf8(_)) -> crash("Unreachable: a string of digits is valid UTF8")
