# Hints

## General

- Maybe you would like to create a DSL based on lists of tags and records, like this:

  ```roc
  my_graph =
      Graph.create([
          Title("My Graph"),
          Node("a", { color: Green }),
          Node("b", { color: Blue }),
          Edge("a", "b", { style: Dotted }),
      ])
  ```

- Or perhaps you would prefer a DSL based on chains of function calls, like this:

  ```roc
  my_graph =
      Graph.create()
          .with_title("My Graph")
          .add_node("a", Attr.create().with_color(Green))
          ...
  ```

  Or maybe you have very a different plan?
  Go for it!

- That said, a DSL is usually better if it is clear, concise, and not too surprising (e.g., the `minus` function is meant for subtracting, not for building an edge between two nodes, as in `node("a") - node("b")`).
