module [find_anagrams]

import unicode.Grapheme

to_upper = |text|
    text
    |> Str.to_utf8
    |> List.map(
        |c|
            if c >= 'a' and c <= 'z' then
                c - 'a' + 'A'
            else
                c,
    )
    |> Str.from_utf8
    |> Result.with_default("Unreachable")

compare_graphemes = |g1, g2|
    s1 = g1 |> Str.to_utf8
    s2 = g2 |> Str.to_utf8
    cmp =
        List.map2(s1, s2, |b1, b2| (b1, b2))
        |> List.walk_until(
            EQ,
            |_, (b1, b2)|
                if b1 == b2 then
                    Continue(EQ)
                else if b1 < b2 then
                    Break(LT)
                else
                    Break(GT),
        )
    if cmp == EQ then
        Num.compare(List.len(s1), List.len(s2))
    else
        cmp

sorted_graphemes = |word|
    graphemes = word |> Grapheme.split?
    graphemes |> List.sort_with(compare_graphemes) |> Ok

is_anagram_of = |word1, word2|
    sorted1 = word1 |> to_upper |> sorted_graphemes?
    sorted2 = word2 |> to_upper |> sorted_graphemes?
    Ok((sorted1 == sorted2))

find_anagrams : Str, List Str -> List Str
find_anagrams = |subject, candidates|
    candidates
    |> List.drop_if(|word| to_upper(word) == to_upper(subject))
    |> List.keep_if(
        |word|
            word |> is_anagram_of(subject) |> Result.with_default(Bool.false),
    )
