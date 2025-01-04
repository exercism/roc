module [to_protein]

Codon : List U8
amino_acid : [Cysteine, Leucine, Methionine, Phenylalanine, Serine, Tryptophan, Tyrosine]
Protein : List amino_acid

to_instruction : Codon -> Result [Append amino_acid, Stop] [InvalidCodon Codon]
to_instruction = \codon ->
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

to_protein : Str -> Result Protein [InvalidCodon Codon]
to_protein = \rna ->
    help = \protein, codons ->
        when codons is
            [] -> Ok protein
            [codon, .. as rest] ->
                when codon |> to_instruction is
                    Ok (Append amino_acid) -> protein |> List.append amino_acid |> help rest
                    Ok Stop -> Ok protein
                    Err err -> Err err
    help [] (rna |> Str.toUtf8 |> List.chunksOf 3)
