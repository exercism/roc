module [
    buildGraph,
    dslForRedBgColor,
    dslForYellowBgColorAndColoredNodesABC,
    dslForGreenTriangleBCD,
    dslForDottedRedEdgeBC,
]

Color : [Black, Red, Green, Blue, Yellow]
Style : [Solid, Dotted]

Graph : {
    bgColor : Color,
    nodes : Dict Str { color : Color },
    edges : Dict (Str, Str) { color : Color, style : Style },
}

DslCommand : [SetBgColor Color, AddNode Str { color : Color }, AddEdge Str Str { color : Color, style : Style }]

buildGraph : List DslCommand -> Graph
buildGraph = \dslCommands ->
    dslCommands
    |> List.walk { bgColor: Black, nodes: Dict.empty {}, edges: Dict.empty {} } \state, command ->
        when command is
            SetBgColor newBgColor ->
                { state & bgColor: newBgColor }

            AddNode id attributes ->
                nodes = state.nodes |> Dict.insert id attributes
                { state & nodes }

            AddEdge id1 id2 attributes ->
                nodes =
                    state.nodes
                    |> Dict.update id1 \maybeAttrs ->
                        when maybeAttrs is
                            Ok existingAttrs -> Ok existingAttrs
                            Err Missing -> Ok { color: Black }
                    |> Dict.update id2 \maybeAttrs ->
                        when maybeAttrs is
                            Ok existingAttrs -> Ok existingAttrs
                            Err Missing -> Ok { color: Black }
                edgeId = if compareStrings id1 id2 == LT then (id1, id2) else (id2, id1)
                edges =
                    state.edges
                    |> Dict.insert edgeId attributes
                { state & nodes, edges }

dslForRedBgColor : List DslCommand
dslForRedBgColor = [
    SetBgColor Red,
]

dslForYellowBgColorAndColoredNodesABC : List DslCommand
dslForYellowBgColorAndColoredNodesABC = [
    SetBgColor Yellow,
    AddNode "a" { color: Red },
    AddNode "b" { color: Green },
    AddNode "c" { color: Blue },
]

dslForGreenTriangleBCD : List DslCommand
dslForGreenTriangleBCD = [
    SetBgColor Yellow,
    AddNode "a" { color: Green },
    AddNode "b" { color: Green },
    AddNode "c" { color: Green },
    AddEdge "a" "b" { color: Green, style: Solid },
    AddEdge "b" "c" { color: Green, style: Solid },
    AddEdge "a" "c" { color: Green, style: Solid },
]

dslForDottedRedEdgeBC : List DslCommand
dslForDottedRedEdgeBC = [
    AddEdge "b" "c" { color: Red, style: Dotted },
]

## Compare two strings, first by their UTF8 representations, then by length:
## "" < "ABC" < "abc" < "abcdef"
## This is used to sort the users in the JSON outputs
compareStrings : Str, Str -> [LT, EQ, GT]
compareStrings = \string1, string2 ->
    b1 = string1 |> Str.toUtf8
    b2 = string2 |> Str.toUtf8
    result =
        List.map2 b1 b2 \c1, c2 -> Num.compare c1 c2
        |> List.walkTry (Ok EQ) \_state, cmp ->
            when cmp is
                EQ -> Ok EQ
                res -> Err res
    when result is
        Ok _cmp -> Num.compare (List.len b1) (List.len b2)
        Err res -> res
