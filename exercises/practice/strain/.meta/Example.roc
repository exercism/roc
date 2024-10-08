module [keep, discard]

keep : List a, (a -> Bool) -> List a
keep = \list, predicate ->
    loop = \sublist, selected ->
        when sublist is
            [] -> selected
            [first, .. as rest] ->
                if predicate first then
                    rest |> loop (List.append selected first)
                else
                    rest |> loop selected

    loop list []

discard : List a, (a -> Bool) -> List a
discard = \list, predicate ->
    loop = \sublist, rejected ->
        when sublist is
            [] -> rejected
            [first, .. as rest] ->
                if !(predicate first) then
                    rest |> loop (List.append rejected first)
                else
                    rest |> loop rejected

    loop list []

