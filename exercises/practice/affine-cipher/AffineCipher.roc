AffineCipher :: { a : U64, b : U64 }.{
	alphabet_size : U64
	alphabet_size = 26

	group_length : U64
	group_length = 5

	new : { a : U64, b : U64 } -> Try(AffineCipher, _)
	new = |key| {
		crash "Please implement the 'new' method"
	}

	encode : Str, AffineCipher -> Try(Str, _)
	encode = |affine_cipher, phrase| {
		crash "Please implement the 'encode' method"
	}

	decode : Str, AffineCipher -> Try(Str, _)
	decode = |affine_cipher, phrase| {
		crash "Please implement the 'decode' method"
	}
}
