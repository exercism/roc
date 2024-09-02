module [sumOfMultiples]

sumOfMultiples = \factors, limit ->
    factors
    |> List.keepIf \factor -> factor > 0
    |> List.joinMap \factor ->
        List.range { start: At factor, end: Before limit, step: factor }
    |> Set.fromList
    |> Set.toList
    |> List.sum
