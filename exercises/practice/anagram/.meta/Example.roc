module [findAnagrams]

import unicode.Grapheme

toUpper = \text ->
    text
    |> Str.toUtf8
    |> List.map \c ->
        if c >= 'a' && c <= 'z' then
            c - 'a' + 'A'
        else
            c
    |> Str.fromUtf8
    |> Result.withDefault "Unreachable"

compareGraphemes = \g1, g2 ->
    s1 = g1 |> Str.toUtf8
    s2 = g2 |> Str.toUtf8
    cmp =
        List.map2 s1 s2 \b1, b2 -> (b1, b2)
        |> List.walkUntil EQ \_, (b1, b2) ->
            if b1 == b2 then
                Continue EQ
            else if b1 < b2 then
                Break LT
            else
                Break GT
    if cmp == EQ then
        Num.compare (List.len s1) (List.len s2)
    else
        cmp

sortedGraphemes = \word ->
    graphemes = word |> Grapheme.split?
    graphemes |> List.sortWith compareGraphemes |> Ok

isAnagramOf = \word1, word2 ->
    sorted1 = word1 |> toUpper |> sortedGraphemes?
    sorted2 = word2 |> toUpper |> sortedGraphemes?
    Ok (sorted1 == sorted2)

findAnagrams = \subject, candidates ->
    candidates
    |> List.dropIf \word -> toUpper word == toUpper subject
    |> List.keepIf \word ->
        word |> isAnagramOf subject |> Result.withDefault Bool.false
