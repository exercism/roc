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

# TODO: change this DslCommand type however you need
DslCommand : [DslCommandTodo1, DslCommandTodo2, DslCommandTodo3]

buildGraph : List DslCommand -> Graph
buildGraph = \dslCommands ->
    crash "Please implement the 'buildGraph' function"

dslForRedBgColor : List DslCommand
dslForRedBgColor = [
    # TODO: define this list of DSL commands to get the desired effect
]

dslForYellowBgColorAndColoredNodesABC : List DslCommand
dslForYellowBgColorAndColoredNodesABC = [
    # TODO: define this list of DSL commands to get the desired effect
]

dslForGreenTriangleBCD : List DslCommand
dslForGreenTriangleBCD = [
    # TODO: define this list of DSL commands to get the desired effect
]

dslForDottedRedEdgeBC : List DslCommand
dslForDottedRedEdgeBC = [
    # TODO: define this list of DSL commands to get the desired effect
]
