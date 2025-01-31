module [flatten]

NestedValue : [Value I64, Null, NestedArray (List NestedValue)]

flatten : NestedValue -> List I64
flatten = |array|
    when array is
        NestedArray(list) -> list |> List.join_map(flatten)
        Value(value) -> [value]
        Null -> []
