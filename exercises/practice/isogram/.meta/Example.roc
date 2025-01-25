module [is_isogram]

is_isogram : Str -> Bool
is_isogram = |phrase|
    chars =
        phrase
        |> Str.to_utf8
        |> List.drop_if(|c| c == ' ' or c == '-')
        |> List.map(|c| if c >= 'a' and c <= 'z' then c + 'A' - 'a' else c) # to uppercase

    (List.len(chars)) == Set.len(Set.from_list(chars))

