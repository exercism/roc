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
evaluate = \program ->
    result =
        lower = toLower program
        operations = parse? lower
        interpret operations

    Result.mapErr result handleError

interpret : List Op -> Result Stack _
interpret = \program ->
    help = \ops, stack ->
        when ops is
            [] -> Ok stack
            [op, .. as rest] ->
                when step stack op is
                    Ok newStack -> help rest newStack
                    Err error -> EvaluationError { error, stack, op, ops } |> Err
    help program []

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
                [.. as rest, x, y] ->
                    quotient = Num.divTruncChecked? x y
                    List.append rest quotient |> Ok

                _ -> Err (Arity 2)

# Parsing
parse : Str -> Result (List Op) _
parse = \str ->
    when Str.splitOn (Str.trim str) "\n" is
        [.. as defLines, program] ->
            defs = parseDefs? defLines

            Str.splitOn program " "
            |> flattenDefs defs
            |> List.mapTry toOp

        [] -> Ok [] # We'll let the empty program return the empty list

parseDefs : List Str -> Result Defs _
parseDefs = \lines ->
    List.walkTry lines (Dict.empty {}) \defs, line ->
        when Str.splitOn line " " is
            [":", name, .. as tokens, ";"] ->
                ops = parseDef? tokens defs
                Dict.insert defs name ops |> Ok

            _ -> Err (UnableToParseDef line)

parseDef : List Str, Defs -> Result (List Str) _
parseDef = \tokens, defs ->
    List.walkTry tokens [] \ops, token ->
        when Dict.get defs token is
            Ok body -> List.concat ops body |> Ok
            _ if isBuiltin token -> List.append ops token |> Ok
            _ -> Err (UnknownName token)

isBuiltin : Str -> Bool
isBuiltin = \token ->
    builtins = ["dup", "drop", "swap", "over", "+", "-", "*", "/"]
    (builtins |> List.contains token) || (Result.isOk (Str.toI16 token))

flattenDefs : List Str, Defs -> List Str
flattenDefs = \tokens, defs ->
    List.joinMap tokens \token ->
        when Dict.get defs token is
            Ok body -> body
            _ -> [token]

toOp : Str -> Result Op _
toOp = \str ->
    when str is
        "dup" -> Ok Dup
        "drop" -> Ok Drop
        "swap" -> Ok Swap
        "over" -> Ok Over
        "+" -> Ok Add
        "-" -> Ok Subtract
        "*" -> Ok Multiply
        "/" -> Ok Divide
        _ ->
            when Str.toI16 str is
                Ok num -> Ok (Number num)
                Err _ -> Err (UnknownName str)
# Display
handleError : _ -> Str
handleError = \err ->
    when err is
        UnknownName key -> "Hmm, I don't know any operations called '$(key)'. Maybe there's a typo?"
        UnableToParseDef line ->
            """
            This is supposed to be a definition, but I'm not sure how to parse it:
            $(line)
            """

        EvaluationError { error, stack, op, ops } ->
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

showExecution : Stack, List Op -> Str
showExecution = \stack, ops ->
    stackStr =
        List.map stack Num.toStr
        |> Str.joinWith " "
    opsStr =
        List.map ops opToStr
        |> Str.joinWith " "
    "$(stackStr) | $(opsStr)"

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

toLower : Str -> Str
toLower = \str ->
    result =
        Str.toUtf8 str
        |> List.map \byte ->
            if 'A' <= byte && byte <= 'Z' then
                byte - 'A' + 'a'
            else
                byte
        |> Str.fromUtf8
    when result is
        Ok s -> s
        _ -> crash "There was an unexpected error converting back to Str"
