# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pov/canonical-data.json
# File last updated on 2024-09-20
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import Pov exposing [fromPov, pathTo]

Tree : [Empty, Node { label : Str, children : Set Tree }]

##
## Reroot a tree so that its root is the specified node.
##

# Results in the same tree if the input tree is a singleton

expect
    tree = Node { label: "x", children: Set.empty {} }
    result = tree |> fromPov "x"
    expected = Node { label: "x", children: Set.empty {} } |> Ok
    result == expected

# Can reroot a tree with a parent and one sibling

expect
    tree =
        Node {
            label: "parent",
            children: Set.fromList [
                Node { label: "x", children: Set.empty {} },
                Node { label: "sibling", children: Set.empty {} },
            ],
        }
    result = tree |> fromPov "x"
    expected =
        Node {
            label: "x",
            children: Set.fromList [
                Node {
                    label: "parent",
                    children: Set.fromList [
                        Node { label: "sibling", children: Set.empty {} },
                    ],
                },
            ],
        }
        |> Ok
    result == expected

# Can reroot a tree with a parent and many siblings

expect
    tree =
        Node {
            label: "parent",
            children: Set.fromList [
                Node { label: "a", children: Set.empty {} },
                Node { label: "x", children: Set.empty {} },
                Node { label: "b", children: Set.empty {} },
                Node { label: "c", children: Set.empty {} },
            ],
        }
    result = tree |> fromPov "x"
    expected =
        Node {
            label: "x",
            children: Set.fromList [
                Node {
                    label: "parent",
                    children: Set.fromList [
                        Node { label: "a", children: Set.empty {} },
                        Node { label: "b", children: Set.empty {} },
                        Node { label: "c", children: Set.empty {} },
                    ],
                },
            ],
        }
        |> Ok
    result == expected

# Can reroot a tree with new root deeply nested in tree

expect
    tree =
        Node {
            label: "level-0",
            children: Set.fromList [
                Node {
                    label: "level-1",
                    children: Set.fromList [
                        Node {
                            label: "level-2",
                            children: Set.fromList [
                                Node {
                                    label: "level-3",
                                    children: Set.fromList [
                                        Node { label: "x", children: Set.empty {} },
                                    ],
                                },
                            ],
                        },
                    ],
                },
            ],
        }
    result = tree |> fromPov "x"
    expected =
        Node {
            label: "x",
            children: Set.fromList [
                Node {
                    label: "level-3",
                    children: Set.fromList [
                        Node {
                            label: "level-2",
                            children: Set.fromList [
                                Node {
                                    label: "level-1",
                                    children: Set.fromList [
                                        Node { label: "level-0", children: Set.empty {} },
                                    ],
                                },
                            ],
                        },
                    ],
                },
            ],
        }
        |> Ok
    result == expected

# Moves children of the new root to same level as former parent

expect
    tree =
        Node {
            label: "parent",
            children: Set.fromList [
                Node {
                    label: "x",
                    children: Set.fromList [
                        Node { label: "kid-0", children: Set.empty {} },
                        Node { label: "kid-1", children: Set.empty {} },
                    ],
                },
            ],
        }
    result = tree |> fromPov "x"
    expected =
        Node {
            label: "x",
            children: Set.fromList [
                Node { label: "kid-0", children: Set.empty {} },
                Node { label: "kid-1", children: Set.empty {} },
                Node { label: "parent", children: Set.empty {} },
            ],
        }
        |> Ok
    result == expected

# Can reroot a complex tree with cousins

expect
    tree =
        Node {
            label: "grandparent",
            children: Set.fromList [
                Node {
                    label: "parent",
                    children: Set.fromList [
                        Node {
                            label: "x",
                            children: Set.fromList [
                                Node { label: "kid-0", children: Set.empty {} },
                                Node { label: "kid-1", children: Set.empty {} },
                            ],
                        },
                        Node { label: "sibling-0", children: Set.empty {} },
                        Node { label: "sibling-1", children: Set.empty {} },
                    ],
                },
                Node {
                    label: "uncle",
                    children: Set.fromList [
                        Node { label: "cousin-0", children: Set.empty {} },
                        Node { label: "cousin-1", children: Set.empty {} },
                    ],
                },
            ],
        }
    result = tree |> fromPov "x"
    expected =
        Node {
            label: "x",
            children: Set.fromList [
                Node { label: "kid-1", children: Set.empty {} },
                Node { label: "kid-0", children: Set.empty {} },
                Node {
                    label: "parent",
                    children: Set.fromList [
                        Node { label: "sibling-0", children: Set.empty {} },
                        Node { label: "sibling-1", children: Set.empty {} },
                        Node {
                            label: "grandparent",
                            children: Set.fromList [
                                Node {
                                    label: "uncle",
                                    children: Set.fromList [
                                        Node { label: "cousin-0", children: Set.empty {} },
                                        Node { label: "cousin-1", children: Set.empty {} },
                                    ],
                                },
                            ],
                        },
                    ],
                },
            ],
        }
        |> Ok
    result == expected

# Errors if target does not exist in a singleton tree

expect
    tree = Node { label: "x", children: Set.empty {} }
    result = tree |> fromPov "nonexistent"
    result == Err NotFound

# Errors if target does not exist in a large tree

expect
    tree =
        Node {
            label: "parent",
            children: Set.fromList [
                Node {
                    label: "x",
                    children: Set.fromList [
                        Node { label: "kid-0", children: Set.empty {} },
                        Node { label: "kid-1", children: Set.empty {} },
                    ],
                },
                Node { label: "sibling-0", children: Set.empty {} },
                Node { label: "sibling-1", children: Set.empty {} },
            ],
        }
    result = tree |> fromPov "nonexistent"
    result == Err NotFound

##
## Given two nodes, find the path between them
##

# Can find path to parent

expect
    tree =
        Node {
            label: "parent",
            children: Set.fromList [
                Node { label: "x", children: Set.empty {} },
                Node { label: "sibling", children: Set.empty {} },
            ],
        }
    result = tree |> pathTo "x" "parent"
    expected = Ok ["x", "parent"]
    result == expected

# Can find path to sibling

expect
    tree =
        Node {
            label: "parent",
            children: Set.fromList [
                Node { label: "a", children: Set.empty {} },
                Node { label: "x", children: Set.empty {} },
                Node { label: "b", children: Set.empty {} },
                Node { label: "c", children: Set.empty {} },
            ],
        }
    result = tree |> pathTo "x" "b"
    expected = Ok ["x", "parent", "b"]
    result == expected

# Can find path to cousin

expect
    tree =
        Node {
            label: "grandparent",
            children: Set.fromList [
                Node {
                    label: "parent",
                    children: Set.fromList [
                        Node {
                            label: "x",
                            children: Set.fromList [
                                Node { label: "kid-0", children: Set.empty {} },
                                Node { label: "kid-1", children: Set.empty {} },
                            ],
                        },
                        Node { label: "sibling-0", children: Set.empty {} },
                        Node { label: "sibling-1", children: Set.empty {} },
                    ],
                },
                Node {
                    label: "uncle",
                    children: Set.fromList [
                        Node { label: "cousin-0", children: Set.empty {} },
                        Node { label: "cousin-1", children: Set.empty {} },
                    ],
                },
            ],
        }
    result = tree |> pathTo "x" "cousin-1"
    expected = Ok ["x", "parent", "grandparent", "uncle", "cousin-1"]
    result == expected

# Can find path not involving root

expect
    tree =
        Node {
            label: "grandparent",
            children: Set.fromList [
                Node {
                    label: "parent",
                    children: Set.fromList [
                        Node { label: "x", children: Set.empty {} },
                        Node { label: "sibling-0", children: Set.empty {} },
                        Node { label: "sibling-1", children: Set.empty {} },
                    ],
                },
            ],
        }
    result = tree |> pathTo "x" "sibling-1"
    expected = Ok ["x", "parent", "sibling-1"]
    result == expected

# Can find path from nodes other than x

expect
    tree =
        Node {
            label: "parent",
            children: Set.fromList [
                Node { label: "a", children: Set.empty {} },
                Node { label: "x", children: Set.empty {} },
                Node { label: "b", children: Set.empty {} },
                Node { label: "c", children: Set.empty {} },
            ],
        }
    result = tree |> pathTo "a" "c"
    expected = Ok ["a", "parent", "c"]
    result == expected

# Errors if destination does not exist

expect
    tree =
        Node {
            label: "parent",
            children: Set.fromList [
                Node {
                    label: "x",
                    children: Set.fromList [
                        Node { label: "kid-0", children: Set.empty {} },
                        Node { label: "kid-1", children: Set.empty {} },
                    ],
                },
                Node { label: "sibling-0", children: Set.empty {} },
                Node { label: "sibling-1", children: Set.empty {} },
            ],
        }
    result = tree |> pathTo "x" "nonexistent"
    result == Err NotFound

# Errors if source does not exist

expect
    tree =
        Node {
            label: "parent",
            children: Set.fromList [
                Node {
                    label: "x",
                    children: Set.fromList [
                        Node { label: "kid-0", children: Set.empty {} },
                        Node { label: "kid-1", children: Set.empty {} },
                    ],
                },
                Node { label: "sibling-0", children: Set.empty {} },
                Node { label: "sibling-1", children: Set.empty {} },
            ],
        }
    result = tree |> pathTo "nonexistent" "x"
    result == Err NotFound

