import parser.Parser
import parser.Utf8

SgfParsing :: {}.{
	NodeProperties : Dict(Str, List(Str))
	GameTree := { properties : NodeProperties, children : List(GameTree) }.{
		# The following line enables the default `is_eq` implementation
		is_eq : _
	}

	parse : Str -> Try(GameTree, _)
	parse = |sgf| {
		crash ("Please implement the 'parse' function")
	}
}
