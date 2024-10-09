module [keep, discard]

keep : List a, (a -> Bool) -> List a
keep = \list, predicate ->
    loop = \sublist, keptItems ->
        when sublist is
            [] -> keptItems
            [first, .. as rest] ->
                if predicate first then
                    rest |> loop (List.append keptItems first)
                else
                    rest |> loop keptItems

    loop list []

discard : List a, (a -> Bool) -> List a
discard = \list, predicate ->
    loop = \sublist, nonDiscardedItems ->
        when sublist is
            [] -> nonDiscardedItems
            [first, .. as rest] ->
                if predicate first then
                    rest |> loop nonDiscardedItems
                else
                    rest |> loop (List.append nonDiscardedItems first)

    loop list []

