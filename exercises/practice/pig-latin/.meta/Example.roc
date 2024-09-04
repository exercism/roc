module [translate]

isVowel = \char ->
    ['a', 'e', 'i', 'o', 'u'] |> List.contains char

rule1Applies = \chars ->
    when chars is
        [c, ..] if isVowel c -> Bool.true
        ['x', 'r', ..] -> Bool.true
        ['y', 't', ..] -> Bool.true
        _ -> Bool.false

pigLatinSwap = \chars ->
    if rule1Applies chars then
        chars
    else
        (_, splitIndex) =
            chars
            |> List.walkUntil (0, 0) \(previousChar, index), char ->
                when (previousChar, char) is
                    ('q', 'u') -> Break (0, index + 1) # rule 3
                    (_, 'y') if index > 0 -> Break (0, index) # rule 4
                    (_, c) if isVowel c -> Break (0, index) # rule 2
                    _ -> Continue (char, index + 1)
        { before, others } = chars |> List.split splitIndex
        others |> List.concat before

translateWord : Str -> Str
translateWord = \word ->
    maybeResult =
        word
        |> Str.toUtf8
        |> pigLatinSwap
        |> List.concat ['a', 'y']
        |> Str.fromUtf8
    when maybeResult is
        Ok result -> result
        Err _ -> crash "Unreachable"

translate : Str -> Str
translate = \phrase ->
    phrase
    |> Str.split " "
    |> List.map translateWord
    |> Str.joinWith " "
