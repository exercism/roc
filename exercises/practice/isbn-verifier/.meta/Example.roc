module [isValid]

charValue = \char, index ->
    if char == 'X' then
        if index == 9 then
            Ok 10
        else
            Err InvalidIsbnBadX
    else if char >= '0' && char <= '9' then
        (10 - index) * (Num.intCast (char - '0')) |> Ok
    else
        Err InvalidIsbnBadChar

isValid = \isbn ->
    chars =
        isbn
        |> Str.toUtf8
        |> List.dropIf \char -> char == '-'
    if List.len chars != 10 then
        Bool.false
    else
        values =
            chars
            |> List.mapWithIndex charValue
            |> List.keepOks \v -> v
        List.len values == 10 && (List.sum values) % 11 == 0
