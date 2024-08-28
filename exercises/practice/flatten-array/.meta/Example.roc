module [flatten]

flatten = \array ->
    when array is
        NestedArray list -> list |> List.joinMap flatten
        Value value -> [value]
        Null -> []
