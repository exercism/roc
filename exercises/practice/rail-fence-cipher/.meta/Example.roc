module [encode, decode]

encoded_indices : U64, U64 -> List U64
encoded_indices = |len, rails|
    indices = List.range({ start: At(0), end: Before(len) })
    List.range({ start: At(0), end: Before(rails) })
    |> List.map(
        |rail|
            period = 2 * (rails - 1)
            indices
            |> List.map_with_index(
                |index, original_index|
                    to_rail = original_index % period
                    if to_rail == rail or to_rail == period - rail then
                        [index]
                    else
                        [],
            )
            |> List.join,
    )
    |> List.join

decoded_indices : U64, U64 -> List U64
decoded_indices = |len, rails|
    encoded_indices(len, rails)
    |> List.map_with_index(|encoded, decoded| { encoded, decoded })
    |> List.sort_with(
        |{ encoded: encoded1 }, { encoded: encoded2 }|
            Num.compare(encoded1, encoded2),
    )
    |> List.map(.decoded)

encode : Str, U64 -> Result Str [ZeroRails, BadUtf8 _]
encode = |message, rails|
    message |> reorder_with(encoded_indices, rails)

decode : Str, U64 -> Result Str [ZeroRails, BadUtf8 _]
decode = |encrypted, rails|
    encrypted |> reorder_with(decoded_indices, rails)

reorder_with : Str, (U64, U64 -> List U64), U64 -> Result Str [ZeroRails, BadUtf8 _]
reorder_with = |message, get_indices, rails|
    if rails == 0 then
        Err(ZeroRails)
    else if rails == 1 then
        Ok(message)
    else
        chars = message |> Str.to_utf8
        result =
            get_indices(List.len(chars), rails)
            |> List.map_try(|index| chars |> List.get(index))
        when result is
            Ok(encrypted_chars) -> encrypted_chars |> Str.from_utf8
            Err(OutOfBounds) -> crash("Unreachable: indices cannot be out of bounds here")
