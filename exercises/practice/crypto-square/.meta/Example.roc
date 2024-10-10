module [ciphertext]

ciphertext : Str -> Result Str _
ciphertext = \text ->
    chars =
        text
        |> Str.toUtf8
        |> List.joinMap \char ->
            if (char >= 'a' && char <= 'z') || (char >= '0' && char <= '9') then
                [char]
            else if char >= 'A' && char <= 'Z' then
                [char - 'A' + 'a']
            else
                []

    length = List.len chars
    width = length |> Num.toF64 |> Num.sqrt |> Num.ceiling |> Num.toU64
    rows = chars |> List.chunksOf width

    List.range { start: At 0, end: Before width }
    |> List.map \column ->
        rows
        |> List.map \row ->
            row |> List.get column |> Result.withDefault ' '
    |> List.intersperse [' ']
    |> List.join
    |> Str.fromUtf8
