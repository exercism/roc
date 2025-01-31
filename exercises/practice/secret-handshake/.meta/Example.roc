module [commands]

commands : U64 -> List Str
commands = |number|
    actions =
        [(1, "wink"), (2, "double blink"), (4, "close your eyes"), (8, "jump")]
        |> List.join_map(
            |(mask, action)|
                if Num.bitwise_and(number, mask) == 0 then [] else [action],
        )

    if Num.bitwise_and(number, 16) == 0 then
        actions
    else
        List.reverse(actions)
