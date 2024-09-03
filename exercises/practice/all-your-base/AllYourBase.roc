module [rebase]

rebase : { inputBase : U64, outputBase : U64, digits : List U64 } -> Result (List U64) _
rebase = \{ inputBase, outputBase, digits } ->
    crash "Please implement 'rebase'"
