module [slices]

slices : Str, U64 -> List Str
slices = |string, slice_length|
    chars = string |> Str.to_utf8
    len = chars |> List.len
    if len == 0 or slice_length == 0 or slice_length > len then
        []
    else
        maybe_list =
            List.range({ start: At(0), end: At((len - slice_length)) })
            |> List.map_try(
                |start_index|
                    chars
                    |> List.sublist({ start: start_index, len: slice_length })
                    |> Str.from_utf8,
            )
        when maybe_list is
            Ok(list) -> list
            Err(BadUtf8(_)) -> crash("Only ASCII strings are supported")
