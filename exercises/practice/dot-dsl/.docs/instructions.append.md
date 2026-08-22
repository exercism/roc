# Instructions append

## Build Your Own DSL

In this exercise, you are entirely free to design the graph DSL of your dreams.

Maybe you would like to create a DSL based on lists of tags and records, like this:

```roc
my_graph =
    Graph.new([
        Title("My Graph"),
        Node("a", { color: Green }),
        Node("b", { color: Blue }),
        Edge("a", "b", { style: Dotted }),
    ])
```

Or perhaps you would prefer a DSL based on chains of function calls, like this:

```roc
my_graph =
    Graph.new
        .with_title("My Graph")
        .add_node("a", Attr.new.with_color(Green))
        ...
```

Or maybe you have very a different plan? Go for it! The tests only require you to create a few specific graphs—the way you build them is totally up to you.

That said, a DSL is usually better if it is clear, concise, and not too surprising (e.g., the `minus` function is meant for subtracting, not for building an edge between two nodes, as in `node("a") - node("b")`).

To double the fun, you can optionally try to implement a `to_dot` function that converts your graph to the DOT format!
