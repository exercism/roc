module [sublist]

sublist : List U8, List U8 -> [Equal, Sublist, Superlist, Unequal]
sublist = |list1, list2|
    when List.len(list1) |> Num.compare(List.len(list2)) is
        GT ->
            when list2 |> sublist(list1) is
                Sublist -> Superlist
                Unequal -> Unequal
                Superlist -> crash("Unreachable: list 2 is shorter than list 1")
                Equal -> crash("Unreachable: list 1 and 2 don't have the same length")

        EQ ->
            if list1 == list2 then Equal else Unequal

        LT ->
            length_diff = List.len(list2) - List.len(list1)
            maybe_equal_index =
                List.range({ start: At(0), end: At(length_diff) })
                |> List.find_first(
                    |start|
                        list2
                        |> List.sublist({ start, len: List.len(list1) })
                        |> Bool.is_eq(list1),
                )

            when maybe_equal_index is
                Ok(_) -> Sublist
                Err(NotFound) -> Unequal
