module [ciphertext]

ciphertext : Str -> Result Str _
ciphertext = |text|
    chars =
        text
        |> Str.to_utf8
        |> List.join_map(
            |char|
                if (char >= 'a' and char <= 'z') or (char >= '0' and char <= '9') then
                    [char]
                else if char >= 'A' and char <= 'Z' then
                    [char - 'A' + 'a']
                else
                    [],
        )

    length = List.len(chars)
    width = length |> Num.to_f64 |> Num.sqrt |> Num.ceiling |> Num.to_u64
    rows = chars |> List.chunks_of(width)

    List.range({ start: At(0), end: Before(width) })
    |> List.map(
        |column|
            rows
            |> List.map(
                |row|
                    row |> List.get(column) |> Result.with_default(' '),
            ),
    )
    |> List.intersperse([' '])
    |> List.join
    |> Str.from_utf8
