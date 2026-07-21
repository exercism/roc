RotationalCipher :: {}.{
	rotate : Str, U8 -> Str
	rotate = |text, shift_key| {
		text
			.to_utf8()
			.map(
				|c| shift_char(c, shift_key),
			)
			->Str.from_utf8()
			?? "Unreachable"
	}
}

shift_char = |c, shift_key| {
	if c >= 'a' and c <= 'z' {
		(c - 'a' + shift_key) % 26 + 'a'
	} else if c >= 'A' and c <= 'Z' {
		(c - 'A' + shift_key) % 26 + 'A'
	} else {
		c
	}
}
