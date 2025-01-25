module [transform]

to_lower : U8 -> U8
to_lower = |char|
    if char >= 'A' and char <= 'Z' then
        char - 'A' + 'a'
    else
        char

transform : Dict U64 (List U8) -> Dict U8 U64
transform = |legacy|
    legacy
    |> Dict.join_map(
        |score, letters|
            letters
            |> List.map(|c| (to_lower(c), score))
            |> Dict.from_list,
    )
