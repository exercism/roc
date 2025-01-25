module [decimal]

decimal : Str -> Result U64 [InvalidCharacter U8]
decimal = |binary_str|
    binary_str
    |> Str.to_utf8
    |> List.map_try(
        |char|
            when char is
                '0' -> Ok(0)
                '1' -> Ok(1)
                c -> Err(InvalidCharacter(c)),
    )?
    |> List.walk(
        0,
        |dec, bit|
            dec * 2 + bit,
    )
    |> Ok
