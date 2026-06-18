RnaTranscription :: {}.{
	to_rna : Str -> Str
	to_rna = |dna| {
		maybe_rna = 
			dna
				.to_utf8()
				.map(
					complement,
				)
				->Str.from_utf8()

		match maybe_rna {
			Ok(rna) => rna
			Err(_) => {
				crash "Unreachable code: toUt8 -> fromUtf8 will always be Ok"
			}
		}
	}
}

complement = |nucleotide| {
	match nucleotide {
		'G' => 'C'
		'C' => 'G'
		'T' => 'A'
		'A' => 'U'
		c => c
	}
}
