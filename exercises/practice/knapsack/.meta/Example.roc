module [maxium_value]

Item : { weight : U64, value : U64 }

maxium_value : { items : List Item, maximum_weight : U64 } -> U64
maxium_value = \{ items, maximum_weight } ->
    when items is
        [] -> 0
        [item, .. as rest] ->
            max_value_without_item = maxium_value { items: rest, maximum_weight }
            if item.weight > maximum_weight then
                max_value_without_item
            else
                max_value_with_item = item.value + maxium_value { items: rest, maximum_weight: maximum_weight - item.weight }
                Num.max max_value_without_item max_value_with_item
