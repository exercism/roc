NucleotideCount :: {}.{
	nucleotide_counts : Str -> Try({ a : U64, c : U64, g : U64, t : U64 }, [InvalidNucleotide(U8)])
	nucleotide_counts = |input| {
		crash "Please implement the 'nucleotide_counts' function"
	}
}
