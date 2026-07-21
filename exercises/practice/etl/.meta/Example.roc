Etl :: {}.{
	transform : Dict(U64, List(U8)) -> Dict(U8, U64)
	transform = |legacy| {
		legacy
			.join_map(
				|score, letters| {
					letters
						.map(
							|c| (to_lower(c), score),
						)
						->Dict.from_list()
				},
			)
	}
}

to_lower : U8 -> U8
to_lower = |char| {
	if char >= 'A' and char <= 'Z' {
		char - 'A' + 'a'
	} else {
		char
	}
}
