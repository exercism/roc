module [toProtein]

Codon : List U8
AminoAcid : [Cysteine, Leucine, Methionine, Phenylalanine, Serine, Tryptophan, Tyrosine]
Protein : List AminoAcid

toInstruction : Codon -> Result [Append AminoAcid, Stop] [KeyNotFound]
toInstruction = \codon ->
    Dict.fromList [
        (['A', 'U', 'G'], Append Methionine),
        (['U', 'U', 'U'], Append Phenylalanine),
        (['U', 'U', 'C'], Append Phenylalanine),
        (['U', 'U', 'A'], Append Leucine),
        (['U', 'U', 'G'], Append Leucine),
        (['U', 'C', 'U'], Append Serine),
        (['U', 'C', 'C'], Append Serine),
        (['U', 'C', 'A'], Append Serine),
        (['U', 'C', 'G'], Append Serine),
        (['U', 'A', 'U'], Append Tyrosine),
        (['U', 'A', 'C'], Append Tyrosine),
        (['U', 'G', 'U'], Append Cysteine),
        (['U', 'G', 'C'], Append Cysteine),
        (['U', 'G', 'G'], Append Tryptophan),
        (['U', 'A', 'A'], Stop),
        (['U', 'A', 'G'], Stop),
        (['U', 'G', 'A'], Stop),
    ]
    |> Dict.get codon

toProtein : Str -> Result Protein [InvalidCodon Codon]
toProtein = \rna ->
    rna
    |> Str.toUtf8
    |> List.chunksOf 3
    |> List.walkUntil [] \protein, codon ->
        when codon |> toInstruction is
            Ok (Append aminoAcid) -> protein |> List.append (Ok aminoAcid) |> Continue
            Ok Stop -> Break protein
            Err KeyNotFound -> protein |> List.append (Err (InvalidCodon codon)) |> Break
    |> List.mapTry \id -> id
