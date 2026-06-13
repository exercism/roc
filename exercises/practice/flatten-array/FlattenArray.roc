FlattenArray :: {}.{
    flatten : NestedValue -> List I64
    flatten = |array|
        crash("Please implement the 'flatten' function")
}


NestedValue : [Value I64, Null, NestedArray (List NestedValue)]
