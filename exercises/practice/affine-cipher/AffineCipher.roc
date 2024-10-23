module [encode, decode]

encode : Str, { a : U64, b : U64 } -> Result Str _
encode = \phrase, key ->
    crash "Please implement the 'encode' function"

decode : Str, { a : U64, b : U64 } -> Result Str _
decode = \phrase, key ->
    crash "Please implement the 'decode' function"
