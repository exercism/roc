module [sublist]

sublist : List a, List a -> [Equal, Sublist, Superlist, Unequal] where a implements Eq
sublist = \list1, list2 ->
    when List.len list1 |> Num.compare (List.len list2) is
        GT ->
            when list2 |> sublist list1 is
                Sublist -> Superlist
                Unequal -> Unequal
                Superlist -> crash "Unreachable: list 2 is shorter than list 1"
                Equal -> crash "Unreachable: list 1 and 2 don't have the same length"

        EQ ->
            if list1 == list2 then Equal else Unequal

        LT ->
            lengthDiff = List.len list2 - List.len list1
            maybeEqualIndex =
                List.range { start: At 0, end: At lengthDiff }
                |> List.findFirst \start ->
                    list2
                    |> List.sublist { start, len: List.len list1 }
                    |> Bool.isEq list1

            when maybeEqualIndex is
                Ok _ -> Sublist
                Err NotFound -> Unequal
