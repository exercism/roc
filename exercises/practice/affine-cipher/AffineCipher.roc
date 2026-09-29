AffineCipher :: { a : U64, b : U64 }.{
	alphabet_size : U64
	alphabet_size = 26

	group_length : U64
	group_length = 5

	create : { a : U64, b : U64 } -> Try(AffineCipher, _)
	create = |key| {
		crash "Please implement the 'create' function"
	}

	encode : AffineCipher, Str -> Str
	encode = |affine_cipher, phrase| {
		crash "Please implement the 'encode' function"
	}

	decode : AffineCipher, Str -> Try(Str, _)
	decode = |affine_cipher, phrase| {
		crash "Please implement the 'decode' function"
	}
}
