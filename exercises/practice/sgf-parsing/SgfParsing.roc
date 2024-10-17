module [parse]

NodeProperties : Dict Str (List Str)

# Note: Empty is unused, it's only here to avoid infinite type recursion because
#       the Roc compiler does not yet understand that an empty List can end the
#       recursion.
GameTree : [Empty, GameNode { properties : NodeProperties, children : List GameTree }]

parse : Str -> Result GameTree _
parse = \sgf ->
    crash "Please implement the 'parse' function"
