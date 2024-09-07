module [evaluate]

evaluate : Str -> Result (List I16) _
evaluate = \program ->
    lowerCase = toLower? program
    { ops, defs } = parse? lowerCase

    simpleOps = flatten? ops defs
    interpret simpleOps

parse : Str -> Result { ops : List Op, defs : Dict Str (List OpsWithDefs) } _
parse = \str ->
    when Str.split str "\n" is
        [.. as defLines, opLine] ->
            ops =
                Str.split opLine " "
                    |> List.mapTry? toOp

            defs = parseDefs? defLines

            Ok { ops, defs }

        [] -> Err EmptyProgram

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
        when toOp token is
            # Def key ->
            #    when Dict.get defs key is
            #        Ok items -> List.concat ops items |> Ok
            #        Err _ -> Err (UnknownDef key)
            Ok op -> List.append ops op |> Ok
            Err e -> Err e

flatten : List OpsWithDefs, Defs -> Result (List Op) _
flatten = \nodes, defs ->
    List.walkTry nodes [] \state, node ->
        when node is
            Def key ->
                when Dict.get defs key is
                    Err _ -> Err (UnknownDef key)
                    Ok body ->
                        List.concat state body |> Ok

            Add | Subtract -> [] |> Ok
            _ -> Ok []

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

OpsWithDefs : Op[Def Str]

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
                Ok num -> Number num |> Ok
                Err _ -> Err (UnknownOp str)

toLower : Str -> Result Str _
toLower = \str ->
    Str.toUtf8 str
    |> List.map \byte ->
        if 'A' <= byte && byte <= 'Z' then
            byte - 'A' + 'a'
        else
            byte
    |> Str.fromUtf8
