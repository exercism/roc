ProteinTranslation :: {}.{
	Codon : List(U8)
	AminoAcid : [Cysteine, Leucine, Methionine, Phenylalanine, Serine, Tryptophan, Tyrosine]
	Protein : List(AminoAcid)

	to_protein : Str -> Try(Protein, _)
	to_protein = |rna| {
		crash "Please implement the 'to_protein' function"
	}
}
