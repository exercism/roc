module [commands]

commands = \number ->
    actions =
        [(1, "wink"), (2, "double blink"), (4, "close your eyes"), (8, "jump")]
        |> List.joinMap \(mask, action) ->
            if Num.bitwiseAnd number mask == 0 then [] else [action]

    if Num.bitwiseAnd number 16 == 0 then
        actions
    else
        List.reverse actions
