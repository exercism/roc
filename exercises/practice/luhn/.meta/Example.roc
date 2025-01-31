module [valid]

valid : Str -> Bool
valid = |number|
    when to_digits(number) is
        Ok(digits) if List.len(digits) > 1 ->
            map_every_other_backwards(
                digits,
                |digit|
                    product = digit * 2
                    if product < 10 then product else product - 9,
            )
            |> List.sum
            |> Num.is_multiple_of(10)

        _ -> Bool.false

to_digits : Str -> Result (List U16) [IllegalCharacter]
to_digits = |number|
    help = |input, digits|
        when input is
            [] -> Ok(digits)
            [byte, .. as rest] if byte == ' ' -> help(rest, digits)
            [byte, .. as rest] if '0' <= byte and byte <= '9' ->
                # convert to U16 to prevent an overflow when summing up the digits
                digit = byte - '0' |> Num.to_u16
                help(rest, List.append(digits, digit))

            _ -> Err(IllegalCharacter)
    help(Str.to_utf8(number), [])

map_every_other_backwards : List a, (a -> a) -> List a
map_every_other_backwards = |list, func|
    help = |state, input|
        when input is
            [.. as rest, x, y] ->
                List.append(state, y)
                |> List.append(func(x))
                |> help(rest)

            [x] -> List.append(state, x)
            [] -> state

    help([], list)
    |> List.reverse
