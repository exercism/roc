module [toProtein]

AminoAcid : [Cysteine, Leucine, Methionine, Phenylalanine, Serine, Tryptophan, Tyrosine]
Protein : List AminoAcid

toProtein : Str -> Result Protein _
toProtein = \rna ->
    crash "Please implement the 'toProtein' function"
