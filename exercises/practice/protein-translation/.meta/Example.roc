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
						Append(amino_acid) => {
							protein.append(amino_acid)->help(rest)
						}
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
	# See https://github.com/roc-lang/roc/issues/9700
	codon_str = codon->Str.from_utf8() ?? {
		crash "Unreachable"
	}
	match codon_str {
		"AUG" => Ok(Append(Methionine))
		"UUU" => Ok(Append(Phenylalanine))
		"UUC" => Ok(Append(Phenylalanine))
		"UUA" => Ok(Append(Leucine))
		"UUG" => Ok(Append(Leucine))
		"UCU" => Ok(Append(Serine))
		"UCC" => Ok(Append(Serine))
		"UCA" => Ok(Append(Serine))
		"UCG" => Ok(Append(Serine))
		"UAU" => Ok(Append(Tyrosine))
		"UAC" => Ok(Append(Tyrosine))
		"UGU" => Ok(Append(Cysteine))
		"UGC" => Ok(Append(Cysteine))
		"UGG" => Ok(Append(Tryptophan))
		"UAA" => Ok(Stop)
		"UAG" => Ok(Stop)
		"UGA" => Ok(Stop)
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
