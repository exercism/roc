Graph :: { title : Str, color : Graph.Color, custom_attributes : Dict(Str, Graph.CustomAttributeValue), nodes : Dict(Str, Graph.Attributes), edges : Dict((Str, Str), Dict(Str, Graph.Attributes)) }.{
	CustomAttributeValue : [
		Text(Str),
		Int(I64),
		True,
		False,
	]

	Color : [Blue, Green]

	Style : [Solid, Dotted]

	Attributes : {
		color : Color,
		style : Style,
		label : Str,
		custom_attributes : Dict(Str, CustomAttributeValue),
	}

	# TODO: Define your DSL here then use it to build the graphs below

	## empty graph
	empty_graph : Graph
	empty_graph = {
		crash
			\\Please use your DSL to build this graph:
			\\
			\\graph {
			\\}
	}

	## graph with one node
	graph_with_one_node : Graph
	graph_with_one_node = {
		crash
			\\Please use your DSL to build this graph:
			\\
			\\graph {
			\\    a;
			\\}
	}

	## graph with one node with attribute
	graph_with_one_node_with_attribute : Graph
	graph_with_one_node_with_attribute = {
		crash
			\\Please use your DSL to build this graph:
			\\
			\\graph {
			\\    a [color=green];
			\\}
	}

	## graph with one edge
	graph_with_one_edge : Graph
	graph_with_one_edge = {
		crash
			\\Please use your DSL to build this graph:
			\\
			\\graph {
			\\    a -- b;
			\\}
	}

	## graph with one attribute
	graph_with_one_attribute : Graph
	graph_with_one_attribute = {
		crash
			\\Please use your DSL to build this graph:
			\\
			\\graph {
			\\    [foo=1];
			\\}
	}

	## graph with comments
	graph_with_comments : Graph
	graph_with_comments = {
		crash
			\\Please use your DSL to build this graph:
			\\
			\\graph {
			\\    # a shell-like comment
			\\    [foo=1];
			\\}
	}

	## graph with nodes, edges, and attributes
	graph_with_nodes_edges_and_attributes : Graph
	graph_with_nodes_edges_and_attributes = {
		crash
			\\Please use your DSL to build this graph:
			\\
			\\graph {
			\\    [foo=1];
			\\    [title="Testing Attrs"];
			\\    a [color=green];
			\\    b [label="Beta!"];
			\\    b -- c;
			\\    a -- b [color=blue];
			\\    [bar=true];
			\\}
	}

	## multiple edges on one line
	multiple_edges_on_one_line : Graph
	multiple_edges_on_one_line = {
		crash
			\\Please use your DSL to build this graph:
			\\
			\\graph {
			\\    a -- b -- c -- d [style=dotted];
			\\}
	}

	## only 1 edge between nodes
	only_1_edge_between_nodes : Graph
	only_1_edge_between_nodes = {
		crash
			\\Please use your DSL to build this graph:
			\\
			\\graph {
			\\    a -- b;
			\\    a -- b;
			\\    b -- a [color=blue];
			\\}
	}
}

compare_strings : Str, Str -> [LT, EQ, GT]
compare_strings = |string1, string2| {
	b1 = string1.to_utf8()
	b2 = string2.to_utf8()
	result =
		b1.map2(b2, |c1, c2| c1.compare(c2))
			.fold_try(
				Ok(EQ),
				|_state, cmp| {
					match cmp {
						EQ => Ok(EQ)
						res => Err(res)
					}
				},
			)
	match result {
		Ok(_cmp) => b1.len().compare(b2.len())
		Err(res) => res
	}
}
