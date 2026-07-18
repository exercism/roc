module [buildGraph, node, edge]

Color : [Black, Red, Green, Blue, Yellow]
Style : [Solid, Dotted]

Graph : {
    bgColor : Color,
    nodes : Dict Str { color : Color },
    edges : Dict (Str, Str) { color : Color, style : Style },
}

DslCommand : [AddNode Str { color : Color }, AddEdge Str Str { color : Color, style : Style }]

node : Str, { color ? Color } -> [AddNode Str { color : Color }]
node = \id, { color ? Black } ->
    crash "Please implement the 'node' function"

edge : Str, Str, { color ? Color, style ? Style } -> [AddEdge Str Str { color : Color, style : Style }]
edge = \id1, id2, { color ? Black, style ? Solid } ->
    crash "Please implement the 'edge' function"

buildGraph : { bgColor ? Color }, List DslCommand -> Graph
buildGraph = \{ bgColor ? Black }, dslCommands ->
    crash "Please implement the 'buildGraph' function"
