module [flatten]

NestedValue : [Value I64, Null, NestedArray (List NestedValue)]

flatten : NestedValue -> List I64
flatten = \array ->
    crash "Please implement the 'flatten' function"
