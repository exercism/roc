module [accumulate]

accumulate : List a, (a -> b) -> List b
accumulate = \list, func ->
    help = \output, input ->
        when input is
            [] -> output
            [first, .. as rest] ->
                List.append output (func first)
                |> help rest

    help [] list
