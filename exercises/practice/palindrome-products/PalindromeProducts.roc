module [smallest, largest]

smallest : { min : U64, max : U64 } -> Result { value : U64, factors : Set (U64, U64) } _
smallest = \{ min, max } ->
    crash "Please implement the 'smallest' function"

largest : { min : U64, max : U64 } -> Result { value : U64, factors : Set (U64, U64) } _
largest = \{ min, max } ->
    crash "Please implement the 'largest' function"
