module [score]

score : Str -> U64
score = \word ->
    word
    |> Str.toUtf8
    |> List.map letterValue
    |> List.sum

toUpper : U8 -> U8
toUpper = \letter ->
    if letter >= 'a' && letter <= 'z' then
        letter - 'a' + 'A'
    else
        letter

letterValue : U8 -> U64
letterValue = \letter ->
    [
        ("AEIOULNRST", 1),
        ("DG", 2),
        ("BCMP", 3),
        ("FHVWY", 4),
        ("K", 5),
        ("JX", 8),
        ("QZ", 10),
    ]
    |> List.findFirst \(letters, _) ->
        letters |> Str.toUtf8 |> List.contains (toUpper letter)
    |> Result.withDefault ("", 0) # ignore invalid characters
    |> .1
