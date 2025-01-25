module [recite]

recite : List Str -> Str
recite = |strings|
    when strings is
        [] -> ""
        [firtst_thing, .. as rest] ->
            rest
            |> List.walk(
                (firtst_thing, []),
                |(thing1, lines), thing2|
                    (thing2, lines |> List.append("For want of a ${thing1} the ${thing2} was lost.")),
            )
            |> .1
            |> List.append("And all for the want of a ${firtst_thing}.")
            |> Str.join_with("\n")
