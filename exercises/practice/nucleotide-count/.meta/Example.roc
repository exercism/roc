module [nucleotideCounts]

nucleotideCounts : Str -> Result { a : U64, c : U64, g : U64, t : U64 } _
nucleotideCounts = \input ->
    bytes = Str.toUtf8 input
    containsInvalidNucleotide = List.any bytes \byte ->
        List.contains ['A', 'C', 'G', 'T'] byte |> Bool.not

    if containsInvalidNucleotide then
        Err InvalidNucleotide
        else

    List.walk bytes { a: 0, c: 0, g: 0, t: 0 } \state, elem ->
        when elem is
            'A' -> { state & a: state.a + 1 }
            'C' -> { state & c: state.c + 1 }
            'G' -> { state & g: state.g + 1 }
            'T' -> { state & t: state.t + 1 }
            _ -> crash "impossible"
    |> Ok
