Graph := {
	title ?: Str,
	color ?: Graph.Color,
	custom_attributes : Dict(Str, Graph.CustomAttributeValue),
	nodes : Dict(Str, Graph.Attributes),
	edges : Dict(Graph.EdgeId, Graph.Attributes),
}.{
	is_eq : _

	Color : [Blue, Green]

	Style : [Solid, Dotted]

	CustomAttributeValue : [
		Text(Str),
		Int(I64),
		True,
		False,
	]

	Attributes : {
		color ?: Color,
		style ?: Style,
		label ?: Str,
		custom_attributes : Dict(Str, CustomAttributeValue),
	}

	EdgeId : (Str, Str) # these two node IDs must be ordered alphabetically

	## DSL definition starts here

	new : Graph
	new = Graph.{
		nodes: Dict.empty(),
		edges: Dict.empty(),
		custom_attributes: Dict.empty(),
	}

	int_attr : Graph, Str, I64 -> Graph
	int_attr = |graph, name, value| {
		custom_attributes = graph.custom_attributes.insert(name, Int(value))
		{ ..graph, custom_attributes }
	}

	bool_attr : Graph, Str, Bool -> Graph
	bool_attr = |graph, name, value| {
		custom_attributes = graph.custom_attributes.insert(name, if value True else False)
		{ ..graph, custom_attributes }
	}

	attr : Graph, Str, Str -> Graph
	attr = |graph, name, value| {
		custom_attributes = graph.custom_attributes.insert(name, Text(value))
		{ ..graph, custom_attributes }
	}

	title : Graph, Str -> Graph
	title = |graph, value| {
		{ ..graph, title: value }
	}

	color : Graph, Color -> Graph
	color = |graph, color| {
		{ ..graph, color }
	}

	Attribute : [Label(Str), Style(Style), Color(Color), Custom(Str, CustomAttributeValue)]

	node : Graph, Str, List(Attribute) -> Graph
	node = |graph, name, attributes| {
		nodes = graph.nodes.insert(name, build_attributes_record(attributes))
		{ ..graph, nodes }
	}

	edge : Graph, List(Str), List(Attribute) -> Graph
	edge = |graph, names, attributes| {
		attrs = build_attributes_record(attributes)
		insert_edges = |updated_graph, remaining_names| {
			match remaining_names {
				[] => updated_graph
				[one] => updated_graph |> insert_edges([one, one])
				[one, two] => {
					edges = updated_graph.edges.insert(edge_id(one, two), attrs)
					{ ..updated_graph, edges }
				}
				[.., last1, last2] => {
					updated_graph |> insert_edges([last1, last2]) |> insert_edges(remaining_names.drop_last(1))
				}
			}
		}
		names.fold(
			graph,
			|g, name| {
				if g.nodes.contains(name) {
					g
				} else {
					nodes = g.nodes.insert(name, { custom_attributes: Dict.empty() })
					{ ..graph, nodes }
				}
			},
		)
			|> insert_edges(names)
	}

	## empty graph
	empty_graph : Graph
	empty_graph = {
		Graph.new
	}

	## graph with one node
	graph_with_one_node : Graph
	graph_with_one_node = {
		Graph.new
			.node("a", [])
	}

	## graph with one node with attribute
	graph_with_one_node_with_attribute : Graph
	graph_with_one_node_with_attribute = {
		Graph.new
			.node("a", [Color(Green)])
	}

	## graph with one edge
	graph_with_one_edge : Graph
	graph_with_one_edge = {
		Graph.new
			.edge(["a", "b"], [])
	}

	## graph with one attribute
	graph_with_one_attribute : Graph
	graph_with_one_attribute = {
		Graph.new
			.int_attr("foo", 1)
	}

	## graph with nodes, edges, and attributes
	graph_with_nodes_edges_and_attributes : Graph
	graph_with_nodes_edges_and_attributes = {
		Graph.new
			.int_attr("foo", 1)
			.title("Testing Attrs")
			.node("a", [Color(Green)])
			.node("b", [Label("Beta!")])
			.edge(["b", "c"], [])
			.edge(["a", "b"], [Color(Blue)])
			.bool_attr("bar", Bool.True)
	}

	## multiple edges on one line
	multiple_edges_on_one_line : Graph
	multiple_edges_on_one_line = {
		Graph.new
			.edge(["a", "b", "c", "d"], [Style(Dotted)])
	}

	## only 1 edge between nodes
	only_1_edge_between_nodes : Graph
	only_1_edge_between_nodes = {
		Graph.new
			.edge(["a", "b"], [])
			.edge(["a", "b"], [])
			.edge(["b", "a"], [Color(Blue)])
	}
}

build_attributes_record : List(Graph.Attribute) -> Graph.Attributes
build_attributes_record = |attributes| {
	init : Graph.Attributes
	init = { custom_attributes: Dict.empty() }
	attributes.fold(
		init,
		|rec, instruction| {
			match instruction {
				Color(color) => { ..rec, color }
				Style(style) => { ..rec, style }
				Label(label) => { ..rec, label }
				Custom(name, value) => {
					custom_attributes = rec.custom_attributes.insert(name, value)
					{ ..rec, custom_attributes }
				}
			}
		},
	)
}

edge_id : Str, Str -> (Str, Str)
edge_id = |node1, node2| {
	match compare_strings(node1, node2) {
		LT | EQ => (node1, node2)
		GT => (node2, node1)
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
