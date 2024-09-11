module [slices]

slices : Str, U64 -> Result (List Str) [StringArg [WasEmpty, WasNotAscii Str], SliceLengthArg [WasZero, WasTooLarge U64 Str]]
slices = \string, sliceLength ->
    chars = string |> Str.toUtf8
    len = chars |> List.len
    if len == 0 then
        StringArg WasEmpty |> Err
    else if sliceLength == 0 then
        SliceLengthArg WasZero |> Err
    else if sliceLength > len then
        SliceLengthArg (WasTooLarge sliceLength string) |> Err
    else
        maybeResult =
            List.range { start: At 0, end: At (len - sliceLength) }
            |> List.map \startIndex ->
                chars
                |> List.sublist { start: startIndex, len: sliceLength }
                |> Str.fromUtf8
        if maybeResult |> List.any Result.isErr then
            StringArg (WasNotAscii string) |> Err
        else
            maybeResult
            |> List.keepOks \x -> x
            |> Ok
