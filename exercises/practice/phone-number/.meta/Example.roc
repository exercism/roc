module [clean]

clean : Str -> Result Str [InvalidNumber]
clean = \phoneNumber ->
    digits =
        phoneNumber
        |> Str.toUtf8
        |> List.keepIf \c -> c >= '0' && c <= '9'

    numDigits = List.len digits
    if numDigits == 10 then
        digits |> checkNumber
    else if numDigits == 11 then
        when digits is
            ['1', .. as rest] -> rest |> checkNumber
            _ -> Err InvalidNumber # only country code 1 is supported
    else
        Err InvalidNumber

checkNumber : List U8 -> Result Str [InvalidNumber]
checkNumber = \digits ->
    when digits is
        [a1, _, _, e1, ..] if a1 == '0' || a1 == '1' || e1 == '0' || e1 == '1' ->
            Err InvalidNumber # area code and exchange must not start with 0 or 1

        _ ->
            when digits |> Str.fromUtf8 is
                Ok number -> Ok number
                Err (BadUtf8 _ _) -> crash "Unreachable: a string of digits is valid UTF8"
