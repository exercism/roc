module [evaluate]

evaluate : Str -> Result (List I16) _
evaluate = \program ->
    lower = toLower? program
    defs = parse? lower
    interpret defs


parse : Str -> Result (List Op) _
parse = \str ->
    when Str.split str "\n" is
        [.. as defLines, opLine] ->
            defs = parseDefs? defLines

            parseProgram? opLine defs |> Ok

        [] -> Err EmptyProgram

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

interpret : List Op -> Result (List I16) _
interpret = \ops ->

    List.walkTry ops [] \stack, op ->
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
                    [.., x, 0] ->
                        Err (DivByZero x)

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
