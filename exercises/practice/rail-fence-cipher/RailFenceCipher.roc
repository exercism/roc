RailFenceCipher :: {}.{
	encode : Str, U64 -> Try(Str, _)
	encode = |message, rails| {
		crash "Please implement the 'encode' function"
	}

	decode : Str, U64 -> Try(Str, _)
	decode = |encrypted, rails| {
		crash "Please implement the 'decode' function"
	}
}
