Hamming :: {}.{
	distance : Str, Str -> Try(U64, [StrandArgsWereNotOfEqualLength(Str, Str)])
	distance = |strand1, strand2| {
		nucleotides1 = strand1.to_utf8()
		nucleotides2 = strand2.to_utf8()
		if nucleotides1.len() == nucleotides2.len() {
			Ok(
				List.map2(
					nucleotides1,
					nucleotides2,
					|n1, n2| {
						if n1 == n2 {
							0
						} else {
							1
						}
					},
				)
					.sum(),
			)
		} else {
			Err(StrandArgsWereNotOfEqualLength(strand1, strand2))
		}
	}
}
