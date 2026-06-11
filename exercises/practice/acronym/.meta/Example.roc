Acronym :: {}.{
	abbreviate : Str -> Str
	abbreviate = |text| {
		bytes = text.to_utf8()

		{ acronym } = bytes.fold(
			{ acronym: [], ready_for_letter: Bool.True },
			|state, byte| {
				if state.ready_for_letter and is_letter(byte) {
					{ acronym: state.acronym.append(byte), ready_for_letter: Bool.False }
				} else if byte == ' ' or byte == '-' {
					{ acronym: state.acronym, ready_for_letter: Bool.True }
				} else {
					state
				}
			},
		)

		capitalized = acronym.map(capitalize)

		match capitalized->Str.from_utf8() {
			Err(_) => {
				crash "There was an error converting the bytes to a Str! This should never happen."
			}
			Ok(str) => str
		}
	}
}

is_letter : U8 -> Bool
is_letter = |byte| {
	('a' <= byte and byte <= 'z')
		or
		('A' <= byte and byte <= 'Z')
}

capitalize : U8 -> U8
capitalize = |byte| {
	if 'a' <= byte and byte <= 'z' {
		byte - 'a' + 'A'
	} else {
		byte
	}
}
