module [maxium_value]

Item : { weight : U64, value : U64 }

maxium_value : { items : List Item, maximum_weight : U64 } -> U64
maxium_value = \{ items, maximum_weight } ->
    crash "Please implement the 'maxium_value' function"
