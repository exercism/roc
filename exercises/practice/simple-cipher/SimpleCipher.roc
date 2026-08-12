import random.Random

SimpleCipher := { key : Str }.{
	create : { key : Str } -> SimpleCipher
	create = |{ key }| {
		crash "Please implement the 'create' function"
	}

	create_random : { random_state : Random.State, key_length : U64 } -> { cipher : SimpleCipher, random_state : Random.State }
	create_random = |{ random_state, key_length }| {
		crash "Please implement the 'create_random' function"
	}

	encode : SimpleCipher, Str -> Str
	encode = |cipher, plaintext| {
		crash "Please implement the 'encode' function"
	}

	decode : SimpleCipher, Str -> Str
	decode = |cipher, ciphertext| {
		crash "Please implement the 'decode' function"
	}
}
