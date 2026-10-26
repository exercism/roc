# Instructions Append

## Build Your Own DSL

In this exercise, you are entirely free to design the graph DSL of your dreams.

The tests only require you to create a few specific graphs—the way you build them is totally up to you.

To double the fun, you can optionally try to implement a `to_dot` function that converts your graph to the DOT format!

## Graph representation

Define your DSL in `Graph.roc`, then use it to construct the graphs requested by the stub.
The two node IDs in each `EdgeId` must be ordered alphabetically.

| Definition | Graph to build |
| --- | --- |
| `empty_graph` | An empty graph |
| `graph_with_one_node` | One node |
| `graph_with_one_node_with_attribute` | One node with an attribute |
| `graph_with_one_edge` | One edge |
| `graph_with_one_attribute` | One graph attribute |
| `graph_with_nodes_edges_and_attributes` | Nodes, edges, and attributes |
| `multiple_edges_on_one_line` | Multiple edges expressed on one line |
| `only_1_edge_between_nodes` | Only one edge between each pair of nodes |
