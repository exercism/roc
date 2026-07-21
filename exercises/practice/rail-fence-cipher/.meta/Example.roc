RailFenceCipher :: {}.{
	encode : Str, U64 -> Try(Str, [ZeroRails, BadUtf8(_), ..])
	encode = |message, rails| {
		reorder_with(message, encoded_indices, rails)
	}

	decode : Str, U64 -> Try(Str, [ZeroRails, BadUtf8(_), ..])
	decode = |encrypted, rails| {
		reorder_with(encrypted, decoded_indices, rails)
	}
}

encoded_indices : U64, U64 -> List(U64)
encoded_indices = |len, rails| {
	indices = (0..<len)->List.from_iter()
	(0..<rails)
		->join_map(
			|rail| {
				period = 2 * (rails - 1)
				indices->join_map(
					|index| {
						to_rail = index % period
						if to_rail == rail or to_rail == period - rail {
							[index]
						} else {
							[]
						}
					},
				)
			},
		)
}

decoded_indices : U64, U64 -> List(U64)
decoded_indices = |len, rails| {
	encoded_indices(len, rails)
		.map_with_index(|encoded, decoded| { encoded, decoded })
		.sort_with(
			|{ encoded: encoded1, decoded: _ }, { encoded: encoded2, decoded: _ }| {
				if encoded1 < encoded2 {
					LT
				} else if encoded1 > encoded2 {
					GT
				} else {
					EQ
				}
			},
		)
		.map(|r| r.decoded)
}

reorder_with : Str, (U64, U64 -> List(U64)), U64 -> Try(Str, [ZeroRails, BadUtf8(_), ..])
reorder_with = |message, get_indices, rails| {
	if rails == 0 {
		Err(ZeroRails)
	} else if rails == 1 {
		Ok(message)
	} else {
		chars = message.to_utf8()
		indices = get_indices(chars.len(), rails)
		result = indices->map_try(|index| chars.get(index))
		match result {
			Ok(encrypted_chars) => Str.from_utf8(encrypted_chars)
			Err(OutOfBounds) => {
				crash "Unreachable: indices cannot be out of bounds here"
			}
		}
	}
}

# The following functions should soon be available in Roc's builtins
join_map : i, (a -> j) -> List(b) where [i.iter : i -> Iter(a), j.iter : j -> Iter(b)]
join_map = |list, func| {
	var $state = []
	for item in list {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}

map_try : i, (a -> Try(b, err)) -> Try(List(b), err) where [i.iter : i -> Iter(a)]
map_try = |list, func| {
	var $state = []
	for item in list {
		$state = $state.append(func(item)?)
	}
	Ok($state)
}