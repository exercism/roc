module [maximumValue]

Item : { weight : U64, value : U64 }

maximumValue : { items : List Item, maximumWeight : U64 } -> U64
maximumValue = \{ items, maximumWeight } ->
    crash "Please implement the 'maximumValue' function"
