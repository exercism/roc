module [flatten]

flatten : [NestedArray (List NestedValue), Null, Value I64] as NestedValue -> List I64
flatten = \array ->
    when array is
        NestedArray list -> list |> List.joinMap flatten
        Value value -> [value]
        Null -> []
