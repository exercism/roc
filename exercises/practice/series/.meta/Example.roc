module [slices]

slices : Str, U64 -> List Str
slices = \string, sliceLength ->
    chars = string |> Str.toUtf8
    len = chars |> List.len
    if len == 0 || sliceLength == 0 || sliceLength > len then
        []
    else
        maybeResult =
            List.range { start: At 0, end: At (len - sliceLength) }
            |> List.map \startIndex ->
                chars
                |> List.sublist { start: startIndex, len: sliceLength }
                |> Str.fromUtf8
        if maybeResult |> List.any Result.isErr then
            []
        else
            maybeResult
            |> List.keepOks \x -> x
