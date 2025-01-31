module [to_protein]

AminoAcid : [Cysteine, Leucine, Methionine, Phenylalanine, Serine, Tryptophan, Tyrosine]
Protein : List AminoAcid

to_protein : Str -> Result Protein _
to_protein = |rna|
    crash("Please implement the 'to_protein' function")
