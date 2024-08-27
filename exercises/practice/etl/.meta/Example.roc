module [transform]

toLower = \char ->
    if char >= 'A' && char <= 'Z' then
        char - 'A' + 'a'
    else
        char

transform = \legacy ->
    legacy
    |> Dict.joinMap \score, letters ->
        letters
        |> List.map \c -> (toLower c, score)
        |> Dict.fromList
