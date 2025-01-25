module [is_pangram]

alphabet =
    List.range({ start: At('A'), end: At('Z') }) |> Set.from_list

is_pangram : Str -> Bool
is_pangram = |sentence|
    sentence
    |> Str.to_utf8
    |> Set.from_list
    |> Set.map(|c| if c >= 'a' and c <= 'z' then c + 'A' - 'a' else c) # to uppercase
    |> Set.keep_if(|c| c >= 'A' and c <= 'Z')
    |> Bool.is_eq(alphabet)
