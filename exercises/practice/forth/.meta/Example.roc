module [evaluate]

# Types
Defs : Dict Str (List Str)
Stack : List I16
Op : [
    Dup,
    Drop,
    Swap,
    Over,
    Add,
    Subtract,
    Multiply,
    Divide,
    Number I16,
]

# Evaluation
evaluate : Str -> Result Stack Str
evaluate = |program|
    result = |_|
        lower = to_lower(program)
        operations = parse(lower)?
        interpret(operations)

    Result.map_err(result({}), handle_error)

interpret : List Op -> Result Stack _
interpret = |program|
    help = |ops, stack|
        when ops is
            [] -> Ok(stack)
            [op, .. as rest] ->
                when step(stack, op) is
                    Ok(new_stack) -> help(rest, new_stack)
                    Err(error) -> EvaluationError({ error, stack, op, ops }) |> Err
    help(program, [])

step : Stack, Op -> Result Stack _
step = |stack, op|
    when op is
        Number(x) ->
            List.append(stack, x) |> Ok

        Dup ->
            when stack is
                [.., x] ->
                    List.append(stack, x) |> Ok

                _ -> Err(Arity(1))

        Drop ->
            when stack is
                [.. as rest, _] -> Ok(rest)
                _ -> Err(Arity(1))

        Swap ->
            when stack is
                [.. as rest, x, y] ->
                    List.append(rest, y)
                    |> List.append(x)
                    |> Ok

                _ -> Err(Arity(2))

        Over ->
            when stack is
                [.. as rest, x, y] ->
                    List.concat(rest, [x, y, x]) |> Ok

                _ -> Err(Arity(2))

        Add ->
            when stack is
                [.. as rest, x, y] ->
                    List.append(rest, (x + y)) |> Ok

                _ -> Err(Arity(2))

        Subtract ->
            when stack is
                [.. as rest, x, y] ->
                    List.append(rest, (x - y)) |> Ok

                _ -> Err(Arity(2))

        Multiply ->
            when stack is
                [.. as rest, x, y] ->
                    List.append(rest, (x * y)) |> Ok

                _ -> Err(Arity(2))

        Divide ->
            when stack is
                [.. as rest, x, y] ->
                    quotient = Num.div_trunc_checked(x, y)?
                    List.append(rest, quotient) |> Ok

                _ -> Err(Arity(2))

# Parsing
parse : Str -> Result (List Op) _
parse = |str|
    when Str.split_on(Str.trim(str), "\n") is
        [.. as def_lines, program] ->
            defs = parse_defs(def_lines)?

            Str.split_on(program, " ")
            |> flatten_defs(defs)
            |> List.map_try(to_op)

        [] -> Ok([]) # We'll let the empty program return the empty list

parse_defs : List Str -> Result Defs _
parse_defs = |lines|
    List.walk_try(
        lines,
        Dict.empty({}),
        |defs, line|
            when Str.split_on(line, " ") is
                [":", name, .. as tokens, ";"] ->
                    ops = parse_def(tokens, defs)?
                    Dict.insert(defs, name, ops) |> Ok

                _ -> Err(UnableToParseDef(line)),
    )

parse_def : List Str, Defs -> Result (List Str) _
parse_def = |tokens, defs|
    List.walk_try(
        tokens,
        [],
        |ops, token|
            when Dict.get(defs, token) is
                Ok(body) -> List.concat(ops, body) |> Ok
                _ if is_builtin(token) -> List.append(ops, token) |> Ok
                _ -> Err(UnknownName(token)),
    )

is_builtin : Str -> Bool
is_builtin = |token|
    builtins = ["dup", "drop", "swap", "over", "+", "-", "*", "/"]
    (builtins |> List.contains(token)) or (Result.is_ok(Str.to_i16(token)))

flatten_defs : List Str, Defs -> List Str
flatten_defs = |tokens, defs|
    List.join_map(
        tokens,
        |token|
            when Dict.get(defs, token) is
                Ok(body) -> body
                _ -> [token],
    )

to_op : Str -> Result Op _
to_op = |str|
    when str is
        "dup" -> Ok(Dup)
        "drop" -> Ok(Drop)
        "swap" -> Ok(Swap)
        "over" -> Ok(Over)
        "+" -> Ok(Add)
        "-" -> Ok(Subtract)
        "*" -> Ok(Multiply)
        "/" -> Ok(Divide)
        _ ->
            when Str.to_i16(str) is
                Ok(num) -> Ok(Number(num))
                Err(_) -> Err(UnknownName(str))

# Display
handle_error : _ -> Str
handle_error = |err|
    when err is
        UnknownName(key) -> "Hmm, I don't know any operations called '${key}'. Maybe there's a typo?"
        UnableToParseDef(line) ->
            """
            This is supposed to be a definition, but I'm not sure how to parse it:
            ${line}
            """

        EvaluationError({ error, stack, op, ops }) ->
            when error is
                Arity(1) ->
                    """
                    Oops! '${op_to_str(op)}' expected 1 argument, but the stack was empty.
                    ${show_execution(stack, ops)}
                    """

                Arity(n) ->
                    """
                    Oops! '${op_to_str(op)}' expected ${Num.to_str(n)} arguments, but there weren't enough on the stack.
                    ${show_execution(stack, ops)}
                    """

                DivByZero ->
                    """
                    Sorry, division by zero is not allowed.
                    ${show_execution(stack, ops)}
                    """

show_execution : Stack, List Op -> Str
show_execution = |stack, ops|
    stack_str =
        List.map(stack, Num.to_str)
        |> Str.join_with(" ")
    ops_str =
        List.map(ops, op_to_str)
        |> Str.join_with(" ")
    "${stack_str} | ${ops_str}"

op_to_str : Op -> Str
op_to_str = |op|
    when op is
        Dup -> "dup"
        Drop -> "drop"
        Swap -> "swap"
        Over -> "over"
        Add -> "+"
        Subtract -> "-"
        Multiply -> "*"
        Divide -> "/"
        Number(num) -> Num.to_str(num)

to_lower : Str -> Str
to_lower = |str|
    result =
        Str.to_utf8(str)
        |> List.map(
            |byte|
                if 'A' <= byte and byte <= 'Z' then
                    byte - 'A' + 'a'
                else
                    byte,
        )
        |> Str.from_utf8
    when result is
        Ok(s) -> s
        _ -> crash("There was an unexpected error converting back to Str")
