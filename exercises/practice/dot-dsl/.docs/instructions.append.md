# Instructions append

## Description of DSL

Here's an example of what the DSL should look like:

```roc
graph = buildGraph { bgColor: Yellow } [
    node "a" { color: Red },
    node "b" { color: Green },
    node "c" {},
    edge "a" "b" { color: Red, style: Dotted },
    edge "b" "c" { color: Blue },
    edge "a" "c" { color: Green },
]
```

This code should build a graph with a yellow background, and three nodes, "a", "b", and "c", respectively colored red, green, and black (which is the default color). They should be connected by 3 edges of different colors and styles: the edge between "a" and "b" should be red and dotted, and the edges between "b" and "c" and between "a" and "c" should be solid (which is the default style) and green.

## The `node` and `edge` Functions

The `node` function should simply create an `AddNode` value with the arguments as payload. This is a DSL command used only by the `buildGraph` function. For example, `node "a" { color: Red }` should return `AddNode "a" { color: Red } `. If an attribute is missing, its default value should be used. For example, `node "c" {}` should return `AddNode "c" { color: Black }`.

Similarly, the `edge` function should create an `AddEdge` value. For example, `edge "a" "b" {}` should return `AddEdge "a" "b" {color: Default, style: Solid}`.

These two simple functions make the DSL code much more pleasant to read & write.

## Objective

Once you have implemented the `node` and `edge` functions (they should be easy), your main goal is to write the `buildGraph` function: it must go through the list of DSL commands and produce the desired graph, represented as a record `{ bgColor: ..., nodes: ..., edges: ...}`.

To double the fun, you can optionally try to implement a `toDot` function that converts the graph to a `Str` with using the Dot format!
