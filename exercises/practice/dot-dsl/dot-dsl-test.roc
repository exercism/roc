# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/dot-dsl/canonical-data.json
# File last updated on 2026-11-21

import Graph

# empty graph:
#     graph {
#     }
expect {
	result : Graph
	result = Graph.empty_graph
	expected : Graph
	expected = { nodes: Dict.empty(), edges: Dict.empty(), custom_attributes: Dict.empty() }
	result == expected
}

# graph with one node:
#     graph {
#         a;
#     }
expect {
	result : Graph
	result = Graph.graph_with_one_node
	expected : Graph
	expected = { nodes: Dict.single("a", { custom_attributes: Dict.empty() }), edges: Dict.empty(), custom_attributes: Dict.empty() }
	result == expected
}

# graph with one node with attribute:
#     graph {
#         a [color=green];
#     }
expect {
	result : Graph
	result = Graph.graph_with_one_node_with_attribute
	expected : Graph
	expected = { nodes: Dict.single("a", { custom_attributes: Dict.empty(), color: Green }), edges: Dict.empty(), custom_attributes: Dict.empty() }
	result == expected
}

# graph with one edge:
#     graph {
#         a -- b;
#     }
expect {
	result : Graph
	result = Graph.graph_with_one_edge
	expected : Graph
	expected = {
		nodes: Dict.from_list([
			("a", { custom_attributes: Dict.empty() }),
			("b", { custom_attributes: Dict.empty() }),
		]),
		edges: Dict.single(("a", "b"), { custom_attributes: Dict.empty() }),
		custom_attributes: Dict.empty(),
	}
	result == expected
}

# graph with one attribute:
#     graph {
#         [foo=1];
#     }
expect {
	result : Graph
	result = Graph.graph_with_one_attribute
	expected : Graph
	expected = { nodes: Dict.empty(), edges: Dict.empty(), custom_attributes: Dict.single("foo", Int(1)) }
	result == expected
}

# graph with nodes, edges, and attributes:
#     graph {
#         [foo=1];
#         [title="Testing Attrs"];
#         a [color=green];
#         b [label="Beta!"];
#         b -- c;
#         a -- b [color=blue];
#         [bar=true];
#     }
expect {
	result : Graph
	result = Graph.graph_with_nodes_edges_and_attributes
	expected : Graph
	expected = {
		nodes: Dict.from_list([
			("a", { custom_attributes: Dict.empty(), color: Green }),
			("b", { custom_attributes: Dict.empty(), label: "Beta!" }),
			("c", { custom_attributes: Dict.empty() }),
		]),
		edges: Dict.from_list([
			(("a", "b"), { custom_attributes: Dict.empty(), color: Blue }),
			(("b", "c"), { custom_attributes: Dict.empty() }),
		]),
		title: "Testing Attrs",
		custom_attributes: Dict.from_list([
			("foo", Int(1)),
			("bar", True),
		]),
	}
	result == expected
}

# multiple edges on one line:
#     graph {
#         a -- b -- c -- d [style=dotted];
#     }
expect {
	result : Graph
	result = Graph.multiple_edges_on_one_line
	expected : Graph
	expected = {
		nodes: Dict.from_list([
			("a", { custom_attributes: Dict.empty() }),
			("b", { custom_attributes: Dict.empty() }),
			("c", { custom_attributes: Dict.empty() }),
			("d", { custom_attributes: Dict.empty() }),
		]),
		edges: Dict.from_list([
			(("a", "b"), { custom_attributes: Dict.empty(), style: Dotted }),
			(("b", "c"), { custom_attributes: Dict.empty(), style: Dotted }),
			(("c", "d"), { custom_attributes: Dict.empty(), style: Dotted }),
		]),
		custom_attributes: Dict.empty(),
	}
	result == expected
}

# only 1 edge between nodes:
#     graph {
#         a -- b;
#         a -- b;
#         b -- a [color=blue];
#     }
expect {
	result : Graph
	result = Graph.only_1_edge_between_nodes
	expected : Graph
	expected = {
		nodes: Dict.from_list([
			("a", { custom_attributes: Dict.empty() }),
			("b", { custom_attributes: Dict.empty() }),
		]),
		edges: Dict.single(("a", "b"), { custom_attributes: Dict.empty(), color: Blue }),
		custom_attributes: Dict.empty(),
	}
	result == expected
}
