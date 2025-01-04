module [nucleotide_counts]

nucleotide_counts : Str -> Result { a : U64, c : U64, g : U64, t : U64 } _
nucleotide_counts = \input ->
    Str.toUtf8 input
    |> List.walkTry { a: 0, c: 0, g: 0, t: 0 } \state, elem ->
        when elem is
            'A' -> Ok { state & a: state.a + 1 }
            'C' -> Ok { state & c: state.c + 1 }
            'G' -> Ok { state & g: state.g + 1 }
            'T' -> Ok { state & t: state.t + 1 }
            _ -> Err (InvalidNucleotide elem)
