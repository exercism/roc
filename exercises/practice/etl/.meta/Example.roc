module [transform]

toLower : U8 -> U8
toLower = \char ->
    if char >= 'A' && char <= 'Z' then
        char - 'A' + 'a'
    else
        char

transform : Dict U64 (List U8) -> Dict U8 U64
transform = \legacy ->
    legacy
    |> Dict.joinMap \score, letters ->
        letters
        |> List.map \c -> (toLower c, score)
        |> Dict.fromList
