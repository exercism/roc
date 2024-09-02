module [steps]

steps : U64 -> Result U64 [NumberArgWasZero]
steps = \number ->
    crash "Please implement the `steps` function"
