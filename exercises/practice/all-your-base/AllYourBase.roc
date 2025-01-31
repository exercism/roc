module [rebase]

rebase : { input_base : U64, output_base : U64, digits : List U64 } -> Result (List U64) _
rebase = |{ input_base, output_base, digits }|
    crash("Please implement 'rebase'")
