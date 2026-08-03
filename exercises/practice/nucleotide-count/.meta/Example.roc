NucleotideCount :: {}.{
	nucleotide_counts : Str -> Try({ a : U64, c : U64, g : U64, t : U64 }, [InvalidNucleotide(U8)])
	nucleotide_counts = |input| {
		input
			.to_utf8()
			.fold_until(
				Ok({ a: 0, c: 0, g: 0, t: 0 }),
				|state_res, elem| {
					match state_res {
						Ok(state) => {
							match elem {
								'A' => Continue(Ok({ ..state, a: state.a + 1 }))
								'C' => Continue(Ok({ ..state, c: state.c + 1 }))
								'G' => Continue(Ok({ ..state, g: state.g + 1 }))
								'T' => Continue(Ok({ ..state, t: state.t + 1 }))
								_ => Break(Err(InvalidNucleotide(elem)))
							}
						}
						Err(err) => Break(Err(err))
					}
				},
			)
	}
}
