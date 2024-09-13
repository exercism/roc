module [slices]

slices : Str, U64 -> List Str
slices = \string, sliceLength ->
    chars = string |> Str.toUtf8
    len = chars |> List.len
    if len == 0 || sliceLength == 0 || sliceLength > len then
        []
    else
        maybeList =
            List.range { start: At 0, end: At (len - sliceLength) }
            |> List.mapTry \startIndex ->
                chars
                |> List.sublist { start: startIndex, len: sliceLength }
                |> Str.fromUtf8
        when maybeList is
            Ok list -> list
            Err (BadUtf8 _ _) -> crash "Only ASCII strings are supported"
