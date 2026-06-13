ProteinTranslation :: {}.{
    to_protein : Str -> Result Protein _
    to_protein = |rna|
        crash("Please implement the 'to_protein' function")
}


AminoAcid : [Cysteine, Leucine, Methionine, Phenylalanine, Serine, Tryptophan, Tyrosine]
Protein : List AminoAcid
