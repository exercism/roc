module [parse]

# HINT: we have added the `roc-parser` package to the app's header in
#       sgf-parsing-test.roc. You can use it if you want, particularly the
#       Core module, and perhaps the String module as well.
#       However, if you prefer to roll out your own solution, that's fine too!
# import parser.Core
# import parser.String

NodeProperties : Dict Str (List Str)

# Note: Empty is unused, it's only here to avoid infinite type recursion because
#       the Roc compiler does not yet understand that an empty List can end the
#       recursion.
GameTree : [Empty, GameNode { properties : NodeProperties, children : List GameTree }]

parse : Str -> Result GameTree _
parse = \sgf ->
    crash "Please implement the 'parse' function"
