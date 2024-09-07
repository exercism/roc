module [evaluate]

evaluate : Str -> Result Stack Str
evaluate = \program ->
    run program
    |> Result.mapErr handleError

run : Str -> Result Stack _
run = \program ->
    lower = toLower? program
    defs = parse? lower
    interpret defs

handleError : _ -> Str
handleError = \err ->
    when err is
        UnknownDef key -> "Hmm, I don't know any operations called '$(key)'. Maybe there's a typo?"
        BadUtf8 _ _ -> "I couldn't convert the input to lowercase. Make sure your input doesn't contain any unicode."
        UnableToParseDef line ->
            """
            This is supposed to be a definition, but I'm not sure how to parse it:
            $(line)
            """
        EvaluationError {error, stack, op, ops} ->
            when error is
                Arity 1 ->
                    """
                    Oops! '$(opToStr op)' expected 1 argument, but the stack was empty.
                    $(showExecution stack ops)
                    """
                Arity n ->
                    """
                    Oops! '$(opToStr op)' expected $(Num.toStr n) arguments, but there weren't enough on the stack.
                    $(showExecution stack ops)
                    """
                DivByZero ->
                    """
                    Sorry, division by zero is not allowed.
                    $(showExecution stack ops)
                    """


parse : Str -> Result (List Op) _
parse = \str ->
    when Str.split str "\n" is
        [.. as defLines, opLine] ->
            defs = parseDefs? defLines

            parseProgram? opLine defs |> Ok

        [] -> Ok [] # We'll let the empty program return the empty list

parseProgram : Str, Defs -> Result (List Op) _
parseProgram = \line, defs ->
    Str.split line " "
    |> List.walkTry [] \ops, token ->
        when toOp token defs is
            Def key ->
                when Dict.get defs key is
                    Ok body -> List.concat ops body |> Ok
                    _ -> Err (UnknownDef key)

            op -> List.append ops op |> Ok

Defs : Dict Str (List Op)
Stack : List I16

parseDefs : List Str -> Result Defs _
parseDefs = \lines ->
    List.walkTry lines (Dict.empty {}) \defs, line ->
        when Str.split line " " is
            [":", name, .. as tokens, ";"] ->
                ops = parseDefLine? tokens defs
                Dict.insert defs name ops |> Ok

            _ -> Err (UnableToParseDef line)

parseDefLine : List Str, Defs -> Result (List Op) _
parseDefLine = \tokens, defs ->
    List.walkTry tokens [] \ops, token ->
        when toOp token defs is
            Def key ->
                when Dict.get defs key is
                    Ok items -> List.concat ops items |> Ok
                    Err _ -> Err (UnknownDef key)

            node -> List.append ops node |> Ok

interpret : List Op -> Result Stack _
interpret = \ops ->
    List.walkTry ops [] \stack, op ->
        step stack op
        |> Result.mapErr \error ->
            EvaluationError {error, stack, op, ops}

step : Stack, Op -> Result Stack _
step = \stack, op ->
    when op is
        Number x ->
            List.append stack x |> Ok

        Dup ->
            when stack is
                [.., x] ->
                    List.append stack x |> Ok

                _ -> Err (Arity 1)

        Drop ->
            when stack is
                [.. as rest, _] -> Ok rest
                _ -> Err (Arity 1)

        Swap ->
            when stack is
                [.. as rest, x, y] ->
                    List.append rest y
                    |> List.append x
                    |> Ok

                _ -> Err (Arity 2)

        Over ->
            when stack is
                [.. as rest, x, y] ->
                    List.concat rest [x, y, x] |> Ok

                _ -> Err (Arity 2)

        Add ->
            when stack is
                [.. as rest, x, y] ->
                    List.append rest (x + y) |> Ok

                _ -> Err (Arity 2)

        Subtract ->
            when stack is
                [.. as rest, x, y] ->
                    List.append rest (x - y) |> Ok

                _ -> Err (Arity 2)

        Multiply ->
            when stack is
                [.. as rest, x, y] ->
                    List.append rest (x * y) |> Ok

                _ -> Err (Arity 2)

        Divide ->
            when stack is
                [.., _, 0] ->
                    Err DivByZero

                [.. as rest, x, y] ->
                    List.append rest (x // y) |> Ok

                _ -> Err (Arity 2)

        Def _ -> crash "This case is impossible"

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
    Def Str,
]

showExecution : Stack, List Op -> Str
showExecution = \stack, ops ->
    stackStr = List.map stack Num.toStr
        |> Str.joinWith " "
    opsStr = List.map ops opToStr
        |> Str.joinWith " "
    "[$(stackStr)] | $(opsStr)"

opToStr : Op -> Str
opToStr = \op ->
    when op is
        Dup -> "dup"
        Drop -> "drop"
        Swap -> "swap"
        Over -> "over"
        Add -> "+"
        Subtract -> "-"
        Multiply -> "*"
        Divide -> "/"
        Number num -> Num.toStr num
        Def key -> key

toOp : Str, Defs -> Op
toOp = \str, defs ->
    when str is
        _ if Dict.contains defs str -> Def str
        "dup" -> Dup
        "drop" -> Drop
        "swap" -> Swap
        "over" -> Over
        "+" -> Add
        "-" -> Subtract
        "*" -> Multiply
        "/" -> Divide
        _ ->
            when Str.toI16 str is
                Ok num -> Number num
                Err _ -> Def str

toLower : Str -> Result Str _
toLower = \str ->
    Str.toUtf8 str
    |> List.map \byte ->
        if 'A' <= byte && byte <= 'Z' then
            byte - 'A' + 'a'
        else
            byte
    |> Str.fromUtf8
