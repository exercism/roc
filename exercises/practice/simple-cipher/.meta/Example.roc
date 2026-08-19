import random.Random

SimpleCipher := { key : Str }.{
	create : { key : Str } -> SimpleCipher
	create = |{ key }| {
		{ key }
	}

	create_random : { random_state : Random.State, key_length : U64 } -> { cipher : SimpleCipher, random_state : Random.State }
	create_random = |{ random_state, key_length }| {
		key_gen =
			Random.bounded_u8('a', 'z')
				|> Random.list(key_length)
				|> Random.map(
					|chars| Str.from_utf8(chars) ?? {
						crash "Unreachable: only a to z are possible"
					},
				)
		{ value, state } = Random.step(random_state, key_gen)
		{ cipher: { key: value }, random_state: state }
	}

	encode : SimpleCipher, Str -> Str
	encode = |cipher, plaintext| {
		transform(cipher, plaintext, |rank, offset| (rank + offset) % 26)
	}

	decode : SimpleCipher, Str -> Str
	decode = |cipher, ciphertext| {
		transform(cipher, ciphertext, |rank, offset| ((rank + 26) - offset) % 26)
	}
}

transform = |cipher, str, compute_new_rank| {
	key_chars = cipher.key.to_utf8()
	str
		.to_utf8()
		.map_with_index(
			|char, index| {
				key_index = index % key_chars.len()
				key_char = key_chars.get(key_index) ?? {
					crash "Unreachable: key_index cannot be out of bounds"
				}
				compute_new_rank(char - 'a', key_char - 'a') + 'a'
			},
		)
		|> Str.from_utf8 ?? {
		crash "Unreachable: only a to z are possible"
	}
}
