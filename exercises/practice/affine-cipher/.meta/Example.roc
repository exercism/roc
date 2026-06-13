AffineCipher :: { a : U64, b : U64, encode_map : List(U8), decode_map : List(U8) }.{
	alphabet_size : U64
	alphabet_size = 26

	group_length : U64
	group_length = 5

	new : { a : U64, b : U64 } -> Try(AffineCipher, [InvalidKey])
	new = |{ a, b }| {
		encode_map : List(U8)
		encode_map = 
			0.to(alphabet_size - 1)
				.map(
					|index| {
						encoded_index = (a * index + b) % alphabet_size
						'a' + (
							encoded_index.to_u8_try() ?? {
								crash "Unreachable"
							},
						)
					},
				)
				->collect()

		if Set.from_list(encode_map).len() < encode_map.len() {
			Err(InvalidKey)
		} else {
			decode_map : List(U8)
			decode_map = 
				encode_map
					.map_with_index(
						|encoded, decoded_index| { encoded, decoded_index },
					)
					.sort_with(
						|{ encoded: encoded1 }, { encoded: encoded2 }| {
							if encoded1 < encoded2 {
								LT
							} else if encoded1 > encoded2 {
								GT
							} else {
								EQ
							}
						},
					)
					.map(
						|pair| {
							(
								pair.decoded_index.to_u8_try() ?? {
									crash "Unreachable"
								},
							) + 'a'
						},
					)

			Ok({ a, b, encode_map, decode_map })
		}
	}

	encode : AffineCipher, Str -> Str
	encode = |affine_cipher, phrase| {
		maybe_result = phrase
			.to_utf8()
			->join_map(
				|char| {
					if char >= '0' and char <= '9' {
						[char]
					} else {
						char_lower = if char >= 'A' and char <= 'Z' {
							char - 'A' + 'a'
						} else {
							char
						}
						if char_lower >= 'a' and char_lower <= 'z' {
							index = U8.to_u64(char_lower) - 'a'
							match affine_cipher.encode_map.get(index) {
								Ok(encoded_char) => [encoded_char]
								Err(OutOfBounds) => {
									crash "Unreachable: index cannot be out of bounds here"
								}
							}
						} else {
							[]
						}
					}
				},
			)
			->chunks_of(group_length)
			->intersperse([' '])
			->join()
			->Str.from_utf8()
		match maybe_result {
			Ok(result) => result
			Err(_) => {
				crash "Unreachable: ASCII characters are always valid UTF-8"
			}
		}
	}

	decode : AffineCipher, Str -> Try(Str, [BadUtf8(_), InvalidCharacter])
	decode = |affine_cipher, phrase| {
		phrase
			.to_utf8()
			->map_try(
				|char| {
					if char == ' ' {
						Ok([])
					} else if char >= '0' and char <= '9' {
						Ok([char])
					} else if char >= 'a' and char <= 'z' {
						index = U8.to_u64(char) - 'a'
						match affine_cipher.decode_map.get(index) {
							Ok(decoded_char) => Ok([decoded_char])
							Err(OutOfBounds) => {
								crash "Unreachable: index cannot be out of bounds here"
							}
						}
					} else {
						Err(InvalidCharacter)
					}
				},
			)?
			->join()
			->Str.from_utf8()
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

collect = |iter| {
	var $state = []
	for item in iter {
		$state = $state.append(item)
	}
	$state
}

intersperse = |list, sep| {
	match list {
		[] | [_] => list
		[first, .. as rest] => [first, sep].concat(intersperse(rest, sep))
	}
}

join = |iter| {
	var $state = []
	for sublist in iter {
		for item in sublist {
			$state = $state.append(item)
		}
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

map_try = |iter, func| {
	var $state = []
	for item in iter {
		$state = $state.append(func(item)?)
	}
	Ok($state)
}
