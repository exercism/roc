module [to_rna]

complement = \nucleotide ->
    when nucleotide is
        'G' -> 'C'
        'C' -> 'G'
        'T' -> 'A'
        'A' -> 'U'
        c -> c # invalid nucleotides are ignored

to_rna : Str -> Str
to_rna = \dna ->
    maybe_rna =
        dna
        |> Str.toUtf8
        |> List.map complement
        |> Str.fromUtf8

    when maybe_rna is
        Ok rna -> rna
        Err _ -> crash "Unreachable code: toUt8 -> fromUtf8 will always be Ok"
