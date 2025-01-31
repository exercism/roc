module [keep, discard]

keep : List a, (a -> Bool) -> List a
keep = |list, predicate|
    loop = |sub_list, kept_items|
        when sub_list is
            [] -> kept_items
            [first, .. as rest] ->
                if predicate(first) then
                    rest |> loop(List.append(kept_items, first))
                else
                    rest |> loop(kept_items)

    loop(list, [])

discard : List a, (a -> Bool) -> List a
discard = |list, predicate|
    loop = |sub_list, non_discarded_items|
        when sub_list is
            [] -> non_discarded_items
            [first, .. as rest] ->
                if predicate(first) then
                    rest |> loop(non_discarded_items)
                else
                    rest |> loop(List.append(non_discarded_items, first))

    loop(list, [])
