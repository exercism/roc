module [sum_of_multiples]

sum_of_multiples : List U64, U64 -> U64
sum_of_multiples = \factors, limit ->
    factors
    |> List.keepIf \factor -> factor > 0
    |> List.joinMap \factor ->
        List.range { start: At factor, end: Before limit, step: factor }
    |> Set.fromList
    |> Set.toList
    |> List.sum
