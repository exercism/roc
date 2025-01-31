module [translate]

is_vowel = |char|
    ['a', 'e', 'i', 'o', 'u'] |> List.contains(char)

rule1_applies = |chars|
    when chars is
        [c, ..] if is_vowel(c) -> Bool.true
        ['x', 'r', ..] -> Bool.true
        ['y', 't', ..] -> Bool.true
        _ -> Bool.false

pig_latin_swap = |chars|
    if rule1_applies(chars) then
        chars
    else
        (_, split_index) =
            chars
            |> List.walk_until(
                (0, 0),
                |(previous_char, index), char|
                    when (previous_char, char) is
                        ('q', 'u') -> Break((0, index + 1)) # rule 3
                        (_, 'y') if index > 0 -> Break((0, index)) # rule 4
                        (_, c) if is_vowel(c) -> Break((0, index)) # rule 2
                        _ -> Continue((char, index + 1)),
            )
        { before, others } = chars |> List.split_at(split_index)
        others |> List.concat(before)

translate_word : Str -> Str
translate_word = |word|
    maybe_result =
        word
        |> Str.to_utf8
        |> pig_latin_swap
        |> List.concat(['a', 'y'])
        |> Str.from_utf8
    when maybe_result is
        Ok(result) -> result
        Err(_) -> crash("Unreachable")

translate : Str -> Str
translate = |phrase|
    phrase
    |> Str.split_on(" ")
    |> List.map(translate_word)
    |> Str.join_with(" ")
