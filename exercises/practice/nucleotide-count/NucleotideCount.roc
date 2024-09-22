module [nucleotideCounts]

nucleotideCounts : Str -> Result { a : U64, c : U64, g : U64, t : U64 } _
nucleotideCounts = \input ->
    crash "Please implement 'nucleotideCounts'"
