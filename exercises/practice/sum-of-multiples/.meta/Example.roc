module [sum_of_multiples]

sum_of_multiples : List U64, U64 -> U64
sum_of_multiples = |factors, limit|
    factors
    |> List.keep_if(|factor| factor > 0)
    |> List.join_map(
        |factor|
            List.range({ start: At(factor), end: Before(limit), step: factor }),
    )
    |> Set.from_list
    |> Set.to_list
    |> List.sum
