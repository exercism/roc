module [encode, decode]

encode : List U32 -> List U8
encode = \integers ->
    crash "Please implement the 'encode' function"

decode : List U8 -> Result (List U32) _
decode = \bytes ->
    crash "Please implement the 'decode' function"
