module [evaluate]

evaluate : Str -> Result (List I16) _
evaluate = \program ->
    lowerCase = toLower? program
    { nodes, defs } = parseProgram? lowerCase

    interpret nodes

# defs =
#    lines
#    |> List.dropLast 1
#    |> getDefs
#
parseProgram : Str -> Result { nodes : List Node, defs : List U8 } _
parseProgram = \str ->
    when Str.split str "\n" is
        [.. as defLines, instructions] ->
            nodes = parse? instructions
            Ok { nodes, defs: [] }

        _ -> Err Foo

interpret : List Node -> Result (List I16) _
interpret = \nodes ->
    List.walkTry nodes [] \stack, node ->
        when node is
            Number x ->
                List.append stack x |> Ok

            _ -> Ok []

parse : Str -> Result (List Node) _
parse = \input ->
    Str.split input " "
    |> List.mapTry toNode

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

toNode : Str -> Result Node _
toNode = \str ->
    when str is
        "dup" -> Ok Dup
        "drop" -> Ok Drop
        "swap" -> Ok Swap
        "+" -> Ok Add
        "-" -> Ok Subtract
        "*" -> Ok Multiply
        "/" -> Ok Divide
        _ -> Ok (Number 10)

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
