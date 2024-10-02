module [toProtein]

Codon : List U8
AminoAcid : [Cysteine, Leucine, Methionine, Phenylalanine, Serine, Tryptophan, Tyrosine]
Protein : List AminoAcid

toInstruction : Codon -> Result [Append AminoAcid, Stop] [InvalidCodon Codon]
toInstruction = \codon ->
    when codon is
        ['A', 'U', 'G'] -> Ok (Append Methionine)
        ['U', 'U', 'U'] -> Ok (Append Phenylalanine)
        ['U', 'U', 'C'] -> Ok (Append Phenylalanine)
        ['U', 'U', 'A'] -> Ok (Append Leucine)
        ['U', 'U', 'G'] -> Ok (Append Leucine)
        ['U', 'C', 'U'] -> Ok (Append Serine)
        ['U', 'C', 'C'] -> Ok (Append Serine)
        ['U', 'C', 'A'] -> Ok (Append Serine)
        ['U', 'C', 'G'] -> Ok (Append Serine)
        ['U', 'A', 'U'] -> Ok (Append Tyrosine)
        ['U', 'A', 'C'] -> Ok (Append Tyrosine)
        ['U', 'G', 'U'] -> Ok (Append Cysteine)
        ['U', 'G', 'C'] -> Ok (Append Cysteine)
        ['U', 'G', 'G'] -> Ok (Append Tryptophan)
        ['U', 'A', 'A'] -> Ok Stop
        ['U', 'A', 'G'] -> Ok Stop
        ['U', 'G', 'A'] -> Ok Stop
        _ -> Err (InvalidCodon codon)

toProtein : Str -> Result Protein [InvalidCodon Codon]
toProtein = \rna ->
    help = \protein, codons ->
        when codons is
            [] -> Ok protein
            [codon, .. as rest] ->
                when codon |> toInstruction is
                    Ok (Append aminoAcid) -> protein |> List.append aminoAcid |> help rest
                    Ok Stop -> Ok protein
                    Err err -> Err err
    help [] (rna |> Str.toUtf8 |> List.chunksOf 3)
