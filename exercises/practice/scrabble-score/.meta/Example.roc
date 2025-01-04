module [score]

score : Str -> U64
score = \word ->
    word
    |> Str.toUtf8
    |> List.map letter_value
    |> List.sum

to_upper : U8 -> U8
to_upper = \letter ->
    if letter >= 'a' && letter <= 'z' then
        letter - 'a' + 'A'
    else
        letter

letter_value : U8 -> U64
letter_value = \letter ->
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
        letters |> Str.toUtf8 |> List.contains (to_upper letter)
    |> Result.withDefault ("", 0) # ignore invalid characters
    |> .1
