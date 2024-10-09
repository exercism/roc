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
            _ -> Err InvalidNumber
    else
        Err InvalidNumber

checkNumber : List U8 -> Result Str [InvalidNumber]
checkNumber = \digits ->
    areaStart = digits |> List.get 0 |> Result.withDefault '0'
    exchangeStart = digits |> List.get 3 |> Result.withDefault '0'
    if areaStart == '0' || areaStart == '1' || exchangeStart == '0' || exchangeStart == '1' then
        Err InvalidNumber
        else

    when digits |> Str.fromUtf8 is
        Ok number -> Ok number
        Err (BadUtf8 _ _) -> crash "Unreachable: a string of digits is valid UTF8"
