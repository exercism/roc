module [toRna]

complement = \nucleotide ->
    when nucleotide is
        'G' -> 'C'
        'C' -> 'G'
        'T' -> 'A'
        'A' -> 'U'
        c -> c # invalid nucleotides are ignored

toRna = \dna ->
    maybeRna =
        dna
        |> Str.toUtf8
        |> List.map complement
        |> Str.fromUtf8

    when maybeRna is
        Ok rna -> rna
        Err _ -> crash "Unreachable code: toUt8 -> fromUtf8 will always be Ok"
