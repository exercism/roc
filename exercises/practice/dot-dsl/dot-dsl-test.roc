# File last updated on 2024-10-21
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import DotDsl exposing [
    buildGraph,
    dslForRedBgColor,
    dslForYellowBgColorAndColoredNodesABC,
    dslForGreenTriangleBCD,
    dslForDottedRedEdgeBC,
]

## The following function is a temporary workaround for Roc issue #7144:
## comparing records containing dicts may return the wrong result depending on
## the internal order of the dict data, so we have to extract the dicts and
## compare them directly.
isEq = \graph1, graph2 ->
    (graph1.bgColor == graph2.bgColor)
    && (graph1.nodes == graph2.nodes)
    && (graph1.edges == graph2.edges)

# Can create an empty graph
expect
    result = buildGraph []
    expected = {
        bgColor: Black,
        nodes: Dict.empty {},
        edges: Dict.empty {},
    }
    result |> isEq expected

# can set the background color
expect
    result = buildGraph dslForRedBgColor
    expected = {
        bgColor: Red,
        nodes: Dict.empty {},
        edges: Dict.empty {},
    }
    result |> isEq expected

# can create a graph with yellow background and three separate nodes of various colors
expect
    result = buildGraph dslForYellowBgColorAndColoredNodesABC
    expected = {
        bgColor: Yellow,
        nodes: Dict.fromList [
            ("a", { color: Red }),
            ("b", { color: Green }),
            ("c", { color: Blue }),
        ],
        edges: Dict.empty {},
    }
    result |> isEq expected

# can create a graph of a triangle BCD with green nodes and edges (and with the default black background)
expect
    result = buildGraph dslForGreenTriangleBCD
    expected = {
        bgColor: Black,
        nodes: Dict.fromList [("b", { color: Green }), ("c", { color: Green }), ("d", { color: Green })],
        edges: Dict.fromList [
            (("b", "c"), { color: Green, style: Solid }),
            (("b", "d"), { color: Green, style: Solid }),
            (("c", "d"), { color: Green, style: Solid }),
        ],
    }
    result |> isEq expected

# creating an edge automatically creates the connected nodes if needed, black by default
expect
    result = buildGraph dslForDottedRedEdgeBC
    expected = {
        bgColor: Black,
        # default to black background
        nodes: Dict.fromList [("b", { color: Black }), ("c", { color: Black })],
        edges: Dict.fromList [(("b", "c"), { color: Red, style: Dotted })],
    }
    result |> isEq expected

# DSL commands can be chained, and existing nodes and edges get updated in the given order
expect
    allCommands =
        dslForYellowBgColorAndColoredNodesABC
        |> List.concat dslForGreenTriangleBCD
        |> List.concat dslForDottedRedEdgeBC
        |> List.concat dslForRedBgColor
    result = buildGraph allCommands
    expected = {
        bgColor: Red,
        nodes: Dict.fromList [
            ("a", { color: Red }),
            ("b", { color: Green }),
            ("c", { color: Green }),
            ("d", { color: Green }),
        ],
        edges: Dict.fromList [
            (("b", "c"), { color: Red, style: Dotted }),
            (("b", "d"), { color: Green, style: Solid }),
            (("c", "d"), { color: Green, style: Solid }),
        ],
    }
    result |> isEq expected

# Running the same DSL commands in a different order changes the result
expect
    allCommands =
        dslForDottedRedEdgeBC
        |> List.concat dslForRedBgColor
        |> List.concat dslForGreenTriangleBCD
        |> List.concat dslForYellowBgColorAndColoredNodesABC
    result = buildGraph allCommands
    expected = {
        bgColor: Yellow,
        nodes: Dict.fromList [
            ("a", { color: Red }),
            ("b", { color: Green }),
            ("c", { color: Blue }),
            ("d", { color: Green }),
        ],
        edges: Dict.fromList [
            (("b", "c"), { color: Green, style: Solid }),
            (("b", "d"), { color: Green, style: Solid }),
            (("c", "d"), { color: Green, style: Solid }),
        ],
    }
    result |> isEq expected
