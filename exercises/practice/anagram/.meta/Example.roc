module [find_anagrams]

import unicode.Grapheme

to_upper = \text ->
    text
    |> Str.toUtf8
    |> List.map \c ->
        if c >= 'a' && c <= 'z' then
            c - 'a' + 'A'
        else
            c
    |> Str.fromUtf8
    |> Result.withDefault "Unreachable"

compare_graphemes = \g1, g2 ->
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

sorted_graphemes = \word ->
    graphemes = word |> Grapheme.split?
    graphemes |> List.sortWith compare_graphemes |> Ok

is_anagram_of = \word1, word2 ->
    sorted1 = word1 |> to_upper |> sorted_graphemes?
    sorted2 = word2 |> to_upper |> sorted_graphemes?
    Ok (sorted1 == sorted2)

find_anagrams : Str, List Str -> List Str
find_anagrams = \subject, candidates ->
    candidates
    |> List.dropIf \word -> to_upper word == to_upper subject
    |> List.keepIf \word ->
        word |> is_anagram_of subject |> Result.withDefault Bool.false