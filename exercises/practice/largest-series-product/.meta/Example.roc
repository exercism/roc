module [largestProduct]

largestProduct : Str, U64 -> Result U64 [SpanWasTooLarge, InvalidDigit]
largestProduct = \digits, span ->
    if span == 0 then
        Ok 1
        else

    chars = digits |> Str.toUtf8
    if List.len chars < span then
        Err SpanWasTooLarge
    else if chars |> List.any \char -> char < '0' || char > '9' then
        Err InvalidDigit
        else

    List.range { start: At 0, end: At (List.len chars - span) }
    |> List.map \startIndex ->
        chars
        |> List.sublist { start: startIndex, len: span }
        |> List.walk 1 \product, char ->
            product * (char - '0' |> Num.toU64)
    |> List.max
    |> Result.onErr \ListWasEmpty -> crash "Unreachable: the list cannot be empty here"

