CryptoSquare :: {}.{
	ciphertext : Str -> Str
	ciphertext = |text| {
		chars = {
			text
				.to_utf8()
				->join_map(
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
				.map(
					|c| [c]->Str.from_utf8() ?? {
						crash "Unreachable"
					},
				)
		}
		length = chars.len()
		width = length->sqrt_ceiling() # to_f64().sqrt().ceiling().to_u64()
		rows = chars->chunks_of(width)

		if width == 0 {
			""
		} else {
			(0..<width)
				.map(
					|column| {
						rows.map(
							|row| {
								row.get(column) ?? " "
							},
						)->Str.join_with("")
					},
				)
				->List.from_iter()
				->Str.join_with(" ")
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

# The following function should soon be available in Roc's builtins
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

join_map = |iter, func| {
	var $state = []
	for item in iter {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}
