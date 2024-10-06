module [maximumValue]

Item : { weight : U64, value : U64 }

maximumValue : { items : List Item, maximumWeight : U64 } -> U64
maximumValue = \{ items, maximumWeight } ->
    when items is
        [] -> 0
        [item, .. as rest] ->
            maxValueWithoutItem = maximumValue { items: rest, maximumWeight }
            if item.weight > maximumWeight then
                maxValueWithoutItem
            else
                maxValueWithItem = item.value + maximumValue { items: rest, maximumWeight: maximumWeight - item.weight }
                Num.max maxValueWithoutItem maxValueWithItem
