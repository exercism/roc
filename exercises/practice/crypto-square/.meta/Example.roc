CryptoSquare :: {}.{
	ciphertext : Str -> Str
	ciphertext = |text| {
		chars = {
			(
				text
					.to_utf8()
					.join_map(
						|char| {
							if (char >= 'a' and char <= 'z') or (char >= '0' and char <= '9') {
								[char]
							} else if char >= 'A' and char <= 'Z' {
								[char - 'A' + 'a']
							} else {
								[]
							}
						},
					)
			).map(
				|c| [c] |> Str.from_utf8 ?? {
					crash "Unreachable"
				},
			)
		}
		length = chars.len()
		width = length |> sqrt_ceiling # to_f64().sqrt().ceiling().to_u64()
		rows = chars.chunks_of(width)

		if width == 0 {
			""
		} else {
			(0..<width)
				.iter()
				.map(
					|column| {
						rows.map(
							|row| {
								row.get(column) ?? " "
							},
						)
							|> Str.join_with("")
					},
				)
				|> List.from_iter
				|> Str.join_with(" ")
		}
	}
}

sqrt_ceiling = |n| {
	var $i = 0
	while $i * $i < n {
		$i = $i + 1
	}
	$i
}
