module [nucleotide_counts]

nucleotide_counts : Str -> Result { a : U64, c : U64, g : U64, t : U64 } _
nucleotide_counts = |input|
    crash("Please implement 'nucleotide_counts'")
