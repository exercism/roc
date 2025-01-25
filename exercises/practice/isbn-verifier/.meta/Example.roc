module [is_valid]

char_value = |char, index|
    if char == 'X' then
        if index == 9 then
            Ok(10)
        else
            Err(InvalidIsbnBadX)
    else if char >= '0' and char <= '9' then
        (10 - index) * (Num.int_cast((char - '0'))) |> Ok
    else
        Err(InvalidIsbnBadChar)

is_valid : Str -> Bool
is_valid = |isbn|
    chars =
        isbn
        |> Str.to_utf8
        |> List.drop_if(|char| char == '-')
    if List.len(chars) != 10 then
        Bool.false
    else
        values =
            chars
            |> List.map_with_index(char_value)
            |> List.keep_oks(|v| v)
        List.len(values) == 10 and (List.sum(values)) % 11 == 0
