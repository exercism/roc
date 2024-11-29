module [solve]

solve : Str -> Result (List (U8, U8)) _
solve = \problem ->
    { addends, sum } = parse? problem

    # We can represent the equation as a dictionary of the letters mapped to their coefficients
    # when we simplify the equation. For example, we can write AB + A + B == C as 11A + 2B + (-1)C == 0.
    # That then becomes this dictionary: `Dict.fromList [('A', 11), ('B', 2), ('C', -1)]
    equation =
        List.walk addends (Dict.empty {}) \dict, term ->
            insertTerm dict term 1
        |> insertTerm sum -1

    leadingDigits =
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

            [letter, .. as rest] ->
                findFirstOk remainingDigits \digit ->
                    if digit == 0 && Set.contains leadingDigits letter then
                        Err InvalidAssignment
                        else

                    # Each digit has to be unique, so once we use a digit we remove it from the pool
                    findMatch (List.append assignments (letter, digit)) rest (Set.remove remainingDigits digit)

    digits = List.range { start: At 0, end: At 9 } |> Set.fromList
    findMatch [] (Dict.keys equation) digits

# Apply a function to each element of a list until the function returns an Ok, then return that value
findFirstOk : Set a, (a -> Result b err) -> Result b [NotFound]
findFirstOk = \set, func ->
    Set.walkUntil set (Err NotFound) \state, elem ->
        when func elem is
            Err _ -> Continue state
            Ok val -> Break (Ok val)

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
                Err Missing -> Ok coeff
                Ok c -> Ok (c + coeff)

parse : Str -> Result { addends : List (List U8), sum : List U8 } _
parse = \problem ->
    { before, after } = Str.splitFirst? problem " == "
    addends =
        Str.splitOn before " + "
        |> List.map Str.toUtf8
    Ok { addends, sum: Str.toUtf8 after }
