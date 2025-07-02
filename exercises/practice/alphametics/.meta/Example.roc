module [solve]

solve : Str -> Result (List (U8, U8)) _
solve = |problem|
    { addends, sum } = parse(problem)?

    # We can represent the equation as a dictionary of the letters mapped to their coefficients
    # when we simplify the equation. For example, we can write AB + A + B == C as 11A + 2B + (-1)C == 0.
    # That then becomes this dictionary: `Dict.from_list [('A', 11), ('B', 2), ('C', -1)]
    equation =
        List.walk(
            addends,
            Dict.empty({}),
            |dict, term|
                insert_term(dict, term, 1),
        )
        |> insert_term(sum, -1)

    leading_digits =
        List.map(
            addends,
            |letters|
                List.first(letters) |> Result.with_default(0),
        )
        |> Set.from_list
        |> Set.insert((List.first(sum) |> Result.with_default(0)))

    find_match = |assignments, remaining_vars, remaining_digits|
        when remaining_vars is
            [] ->
                total_val =
                    List.walk(
                        assignments,
                        0,
                        |total, (letter, value)|
                            Dict.get(equation, letter)
                            |> Result.with_default(0)
                            |> Num.mul(Num.to_i64(value))
                            |> Num.add(total),
                    )

                if total_val != 0 then
                    Err(InvalidAssignment)
                else
                    Ok(assignments)

            [letter, .. as rest] ->
                find_first_ok(
                    remaining_digits,
                    |digit|
                        if digit == 0 and Set.contains(leading_digits, letter) then
                            Err(InvalidAssignment)
                        else
                            # Each digit has to be unique, so once we use a digit we remove it from the pool
                            find_match(List.append(assignments, (letter, digit)), rest, Set.remove(remaining_digits, digit)),
                )

    digits = List.range({ start: At(0), end: At(9) }) |> Set.from_list
    find_match([], Dict.keys(equation), digits)

# Apply a function to each element of a list until the function returns an Ok, then return that value
find_first_ok : Set a, (a -> Result b err) -> Result b [NotFound]
find_first_ok = |set, func|
    Set.walk_until(
        set,
        Err(NotFound),
        |state, elem|
            when func(elem) is
                Err(_) -> Continue(state)
                Ok(val) -> Break(Ok(val)),
    )

# Update the equation with the values of a term
insert_term : Dict U8 I64, List U8, I64 -> Dict U8 I64
insert_term = |equation, letters, polarity|
    List.reverse(letters)
    |> List.walk_with_index(
        equation,
        |dict, letter, index|
            coeff =
                Num.pow_int(10, index)
                |> Num.to_i64
                |> Num.mul(polarity)
            Dict.update(
                dict,
                letter,
                |val|
                    when val is
                        Err(Missing) -> Ok(coeff)
                        Ok(c) -> Ok((c + coeff)),
            ),
    )

parse : Str -> Result { addends : List (List U8), sum : List U8 } _
parse = |problem|
    { before, after } = Str.split_first(problem, " == ")?
    addends =
        Str.split_on(before, " + ")
        |> List.map(Str.to_utf8)
    Ok({ addends, sum: Str.to_utf8(after) })
