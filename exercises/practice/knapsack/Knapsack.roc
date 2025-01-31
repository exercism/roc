module [maximum_value]

Item : { weight : U64, value : U64 }

maximum_value : { items : List Item, maximum_weight : U64 } -> U64
maximum_value = |{ items, maximum_weight }|
    crash("Please implement the 'maximum_value' function")
