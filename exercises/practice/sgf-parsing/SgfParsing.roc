SgfParsing :: {}.{
	NodeProperties : Dict(Str, List(Str))
	GameTree : [GameNode, { properties : NodeProperties, children : List(GameTree) }]

	parse : Str -> Try(GameTree, _)
	parse = |sgf| {
		crash ("Please implement the 'parse' function")
	}
}

# HINT: we have added the `roc-parser` package to the app's header in
#       sgf-parsing-test.roc. You can use it if you want, particularly the
#       Core module, and perhaps the String module as well.
#       However, if you prefer to roll out your own solution, that's fine too!
# import parser.Core
# import parser.String
