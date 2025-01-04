module [is_isogram]

is_isogram : Str -> Bool
is_isogram = \phrase ->
    chars =
        phrase
        |> Str.toUtf8
        |> List.dropIf \c -> c == ' ' || c == '-'
        |> List.map \c -> if c >= 'a' && c <= 'z' then c + 'A' - 'a' else c # to uppercase

    (List.len chars) == Set.len (Set.fromList chars)

