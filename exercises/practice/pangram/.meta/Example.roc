module [isPangram]

alphabet =
    List.range { start: At 'A', end: At 'Z' } |> Set.fromList

isPangram = \sentence ->
    sentence
    |> Str.toUtf8
    |> Set.fromList
    |> Set.map \c -> if c >= 'a' && c <= 'z' then c + 'A' - 'a' else c  # to uppercase
    |> Set.keepIf \c -> c >= 'A' && c <= 'Z'
    |> Bool.isEq alphabet
