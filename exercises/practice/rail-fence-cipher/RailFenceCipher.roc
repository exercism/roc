module [encode, decode]

encode : Str, U64 -> Result Str _
encode = \message, rails ->
    crash "Please implement the 'encode' function"

decode : Str, U64 -> Result Str _
decode = \encrypted, rails ->
    crash "Please implement the 'decode' function"
