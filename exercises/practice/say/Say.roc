module [say]

say : U64 -> Result Str [OutOfBounds]
say = \number ->
    crash "Please implement the 'say' function"
