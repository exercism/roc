# File last updated on 2024-10-21
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import DotDsl exposing [buildGraph, node, edge]

## The following function is a temporary workaround for Roc issue #7144:
## comparing records containing dicts may return the wrong result depending on
## the internal order of the dict data, so we have to extract the dicts and
## compare them directly.
isEq = \graph1, graph2 ->
    (graph1.bgColor == graph2.bgColor)
    && (graph1.nodes == graph2.nodes)
    && (graph1.edges == graph2.edges)

# Can create an AddNode command
expect
    result = node "a" { color: Red }
    expected = AddNode "a" { color: Red }
    result == expected

# Can create an AddNode command with the default color
expect
    result = node "b" {}
    expected = AddNode "b" { color: Black }
    result == expected

# Can create an AddEdge command
expect
    result = edge "a" "b" { color: Red, style: Dotted }
    expected = AddEdge "a" "b" { color: Red, style: Dotted }
    result == expected

# Can create an AddEdge command with the default color and style
expect
    result = edge "c" "d" {}
    expected = AddEdge "c" "d" { color: Black, style: Solid }
    result == expected

# Can create an empty graph
expect
    result = buildGraph {} []
    expected = {
        bgColor: Black,
        nodes: Dict.empty {},
        edges: Dict.empty {},
    }
    result |> isEq expected

# can set the background color
expect
    result = buildGraph { bgColor: Red } []
    expected = {
        bgColor: Red,
        nodes: Dict.empty {},
        edges: Dict.empty {},
    }
    result |> isEq expected

# can create a graph with a few nodes of various colors
expect
    result = buildGraph {} [
        node "a" {},
        node "b" { color: Green },
        node "c" { color: Blue },
    ]
    expected = {
        bgColor: Black,
        nodes: Dict.fromList [("a", { color: Black }), ("b", { color: Green }), ("c", { color: Blue })],
        edges: Dict.empty {},
    }
    result |> isEq expected

# can create a graph with a two nodes connected by one edge
expect
    result = buildGraph {} [
        node "a" {},
        node "b" {},
        edge "a" "b" { color: Yellow, style: Dotted },
    ]
    expected = {
        bgColor: Black,
        nodes: Dict.fromList [("a", { color: Black }), ("b", { color: Black })],
        edges: Dict.fromList [(("a", "b"), { color: Yellow, style: Dotted })],
    }
    result |> isEq expected

# creating an edge automatically creates the nodes if they don't exist yet
expect
    result = buildGraph {} [
        edge "a" "b" {},
    ]
    expected = {
        bgColor: Black,
        nodes: Dict.fromList [("a", { color: Black }), ("b", { color: Black })],
        edges: Dict.fromList [(("a", "b"), { color: Black, style: Solid })],
    }
    result |> isEq expected

# creating a node after an edge it's connected to is possible
expect
    result = buildGraph {} [
        edge "a" "b" { color: Red },
        node "a" { color: Blue },
    ]
    expected = {
        bgColor: Black,
        nodes: Dict.fromList [("a", { color: Blue }), ("b", { color: Black })],
        edges: Dict.fromList [(("a", "b"), { color: Red, style: Solid })],
    }
    result |> isEq expected

# can create a multicolor triangle
expect
    result = buildGraph { bgColor: Yellow } [
        node "a" { color: Red },
        node "b" { color: Green },
        node "c" { color: Blue },
        edge "a" "b" { color: Red, style: Dotted },
        edge "b" "c" { color: Blue },
        edge "a" "c" { color: Green },
    ]
    expected = {
        bgColor: Yellow,
        nodes: Dict.fromList [("a", { color: Red }), ("b", { color: Green }), ("c", { color: Blue })],
        edges: Dict.fromList [
            (("a", "b"), { color: Red, style: Dotted }),
            (("b", "c"), { color: Blue, style: Solid }),
            (("a", "c"), { color: Green, style: Solid }),
        ],
    }
    result |> isEq expected

# edge ids are sorted alphabetically
expect
    result = buildGraph {} [
        edge "b" "a" {},
        edge "c" "b" {},
        edge "c" "a" {},
    ]
    expected = {
        bgColor: Black,
        nodes: Dict.fromList [("a", { color: Black }), ("b", { color: Black }), ("c", { color: Black })],
        edges: Dict.fromList [
            (("a", "b"), { color: Black, style: Solid }),
            (("b", "c"), { color: Black, style: Solid }),
            (("a", "c"), { color: Black, style: Solid }),
        ],
    }
    result |> isEq expected

# adding the same node or edge multiple times only keeps the last occurrence
expect
    result = buildGraph {} [
        node "a" { color: Blue },
        node "a" { color: Red },
        node "a" { color: Green },
        edge "a" "b" { color: Yellow },
    ]
    expected = {
        bgColor: Black,
        nodes: Dict.fromList [("a", { color: Green }), ("b", { color: Black })],
        edges: Dict.fromList [
            (("a", "b"), { color: Yellow, style: Solid }),
        ],
    }
    result |> isEq expected
