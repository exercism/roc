VariableLengthQuantity :: {}.{
	encode : List(U32) -> List(U8)
	encode = |integers| {
		integers->join_map(encode_integer)
	}

	decode : List(U8) -> Try(List(U32), [IncompleteSequence])
	decode = |bytes| {
		match bytes {
			[] => Err(IncompleteSequence)
			[.., last] if last >= 128 => Err(IncompleteSequence)
			_ => {
				res = bytes.fold(
					{ integers: [], integer: 0 },
					|state, byte| {
						last_7_bits = byte % 128
						integer = state.integer * 128 + last_7_bits.to_u32()
						if byte >= 128 {
							{ ..state, integer }
						} else {
							{ integers: state.integers.append(integer), integer: 0 }
						}
					},
				)
				Ok(res.integers)
			}
		}
	}
}

encode_integer : U32 -> List(U8)
encode_integer = |integer| {
	help : List(U8), U32 -> List(U8)
	help = |bytes, n| {
		if n == 0 {
			bytes
		} else {
			next_n = n // 128
			last_7_bits = (n % 128).to_u8_try() ?? {
				crash "Unreachable"
			}
			byte = match bytes {
				[] => last_7_bits
				_ => last_7_bits + 128
			}
			help(bytes.append(byte), next_n)
		}
	}
	if integer == 0 {
		[0]
	} else {
		help([], integer)->reverse()
	}
}

# The following functions should soon be available in Roc's builtins
join_map = |iter, func| {
	var $state = []
	for item in iter {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}

reverse : List(a) -> List(a)
reverse = |list| {
	match list {
		[] => []
		[first, .. as rest] => reverse(rest).append(first)
	}
}
