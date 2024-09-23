module [recite]

recite : List Str -> Str
recite = \strings ->
    when strings is
        [] -> ""
        [firstThing, .. as rest] ->
            rest
            |> List.walk (firstThing, []) \(thing1, lines), thing2 ->
                (thing2, lines |> List.append "For want of a $(thing1) the $(thing2) was lost.")
            |> .1
            |> List.append "And all for the want of a $(firstThing)."
            |> Str.joinWith "\n"
