module [evaluate]

evaluate : Str -> Result (List I16) _
evaluate = \program ->
    lowerCase = toLower? program
    { nodes, defs } = parse? lowerCase

    interpret nodes

parse : Str -> Result { nodes : List Node, defs : List U8 } _
parse = \str ->
    when Str.split str "\n" is
        [.. as defLines, instructions] ->
            nodes =
                Str.split instructions " "
                |> List.map toNode

            Ok { nodes, defs: [] }

        _ -> Err Foo

interpret : List Node -> Result (List I16) _
interpret = \nodes ->
    List.walkTry nodes [] \stack, node ->
        when node is
            Number x ->
                List.append stack x |> Ok

            Dup ->
                when stack is
                    [.., x] ->
                        List.append stack x |> Ok

                    _ -> Err (Arity node 1)

            Drop ->
                when stack is
                    [.. as rest, _] -> Ok rest
                    _ -> Err (Arity node 1)

            Swap ->
                when stack is
                    [.. as rest, x, y] ->
                        List.append rest y
                        |> List.append x
                        |> Ok

                    _ -> Err (Arity node 2)

            Over ->
                when stack is
                    [.. as rest, x, y] ->
                        List.concat rest [x, y, x] |> Ok

                    _ -> Err (Arity node 2)

            Add ->
                when stack is
                    [.. as rest, x, y] ->
                        List.append rest (x + y) |> Ok

                    _ -> Err (Arity node 2)

            Subtract ->
                when stack is
                    [.. as rest, x, y] ->
                        List.append rest (x - y) |> Ok

                    _ -> Err (Arity node 2)

            Multiply ->
                when stack is
                    [.. as rest, x, y] ->
                        List.append rest (x * y) |> Ok

                    _ -> Err (Arity node 2)

            Divide ->
                when stack is
                    [.., x, 0] ->
                        Err (DivByZero x)

                    [.. as rest, x, y] ->
                        List.append rest (x // y) |> Ok

                    _ -> Err (Arity node 2)

            Def str -> Err (DefNotImpl str)

Node : [
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

toNode : Str -> Node
toNode = \str ->
    when str is
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

# getDefs : List Str -> Result (Dict Str (List Node)) _
# getDefs = \lines ->
#    List.walkTry lines (Dict.empty {}) \dict, line ->
#        when Str.split line " " is
#            [":", name, .. as body, ";"] ->
#                List.map body \term ->

#                |> Ok

#            _ -> Err (UnableToParseDef line)

toLower : Str -> Result Str _
toLower = \str ->
    Str.toUtf8 str
    |> List.map \byte ->
        if 'A' <= byte && byte <= 'Z' then
            byte - 'A' + 'a'
        else
            byte
    |> Str.fromUtf8
