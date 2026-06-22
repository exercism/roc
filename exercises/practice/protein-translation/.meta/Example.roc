ProteinTranslation :: {}.{
	Codon : List(U8)
	AminoAcid : [Cysteine, Leucine, Methionine, Phenylalanine, Serine, Tryptophan, Tyrosine]
	Protein : List(AminoAcid)

	to_protein : Str -> Try(Protein, [InvalidCodon(Codon)])
	to_protein = |rna| {
		help : Protein, List(Codon) -> Try(Protein, [InvalidCodon(Codon)])
		help = |protein, codons| {
			match codons {
				[] => Ok(protein)
				[codon, .. as rest] => {
					match to_instruction(codon)? {
						Append(amino_acid) => protein.append(amino_acid)->help(rest)
						Stop => Ok(protein)
					}
				}
			}
		}
		help([], rna.to_utf8()->chunks_of(3))
	}
}

to_instruction : Codon -> Try([Append(AminoAcid), Stop], [InvalidCodon(Codon)])
to_instruction = |codon| {
	match codon {
		['A', 'U', 'G'] => Ok(Append(Methionine))
		['U', 'U', 'U'] => Ok(Append(Phenylalanine))
		['U', 'U', 'C'] => Ok(Append(Phenylalanine))
		['U', 'U', 'A'] => Ok(Append(Leucine))
		['U', 'U', 'G'] => Ok(Append(Leucine))
		['U', 'C', 'U'] => Ok(Append(Serine))
		['U', 'C', 'C'] => Ok(Append(Serine))
		['U', 'C', 'A'] => Ok(Append(Serine))
		['U', 'C', 'G'] => Ok(Append(Serine))
		['U', 'A', 'U'] => Ok(Append(Tyrosine))
		['U', 'A', 'C'] => Ok(Append(Tyrosine))
		['U', 'G', 'U'] => Ok(Append(Cysteine))
		['U', 'G', 'C'] => Ok(Append(Cysteine))
		['U', 'G', 'G'] => Ok(Append(Tryptophan))
		['U', 'A', 'A'] => Ok(Stop)
		['U', 'A', 'G'] => Ok(Stop)
		['U', 'G', 'A'] => Ok(Stop)
		_ => Err(InvalidCodon(codon))
	}
}

# The following functions should soon be available in Roc's builtins
chunks_of = |iter, size| {
	var $state = []
	var $chunk = []
	for item in iter {
		$chunk = $chunk.append(item)
		if $chunk.len() == size {
			$state = $state.append($chunk)
			$chunk = []
		}
	}
	if $chunk.len() > 0 {
		$state = $state.append($chunk)
	}
	$state
}
