module [solve]

solve : Str -> Result (List (U8, U8)) _
solve = \problem ->
    { addends, sum } = parse? problem

    equation =
        List.walk addends (Dict.empty {}) \dict, term ->
            insertTerm dict term 1
        |> insertTerm sum -1

    cantBeZero =
        List.map addends \letters ->
            List.first letters |> Result.withDefault 0
        |> Set.fromList
        |> Set.insert (List.first sum |> Result.withDefault 0)

    findMatch = \assignments, remainingVars, remainingDigits ->
        when remainingVars is
            [] ->
                totalVal =
                    List.walk assignments 0 \total, (letter, value) ->
                        Dict.get equation letter
                        |> Result.withDefault 0
                        |> Num.mul (Num.toI64 value)
                        |> Num.add total

                if totalVal != 0 then
                    Err InvalidAssignment
                    else

                Ok assignments

            [variable, .. as rest] ->
                findFirstOk (Set.toList remainingDigits) \digit ->
                    if digit == 0 && Set.contains cantBeZero variable then
                        Err InvalidAssignment
                        else

                    findMatch (List.append assignments (variable, digit)) rest (Set.remove remainingDigits digit)

    findMatch [] (Dict.keys equation) (List.range { start: At 0, end: At 9 } |> Set.fromList)

# Apply a function to each element of a list until the function returns an Ok, then return that value.
findFirstOk : List a, (a -> Result b err) -> Result b [NotFound]
findFirstOk = \list, func ->
    when list is
        [] -> Err NotFound
        [first, .. as rest] ->
            func first
            |> Result.onErr \_ -> findFirstOk rest func

# Update the equation with the values of a term
insertTerm : Dict U8 I64, List U8, I64 -> Dict U8 I64
insertTerm = \equation, letters, polarity ->
    List.reverse letters
    |> List.walkWithIndex equation \dict, letter, index ->
        coeff =
            Num.powInt 10 index
            |> Num.toI64
            |> Num.mul polarity
        Dict.update dict letter \val ->
            when val is
                Missing -> Present coeff
                Present c -> Present (c + coeff)

parse : Str -> Result { addends : List (List U8), sum : List U8 } _
parse = \problem ->
    { before, after } = Str.splitFirst? problem " == "
    addends =
        Str.split before " + "
        |> List.map Str.toUtf8
    Ok { addends, sum: Str.toUtf8 after }
