LineUp :: {}.{
	format : Str, U64 -> Str
	format = |name, rank| {
		"${name}, you are the ${rank.to_str()}${ending(rank)} customer we serve today. Thank you!"
	}
}

ending : U64 -> Str
ending = |rank| {
	match rank % 100 {
		11 | 12 | 13 => "th"
		_ => match rank % 10 {
			1 => "st"
			2 => "nd"
			3 => "rd"
			_ => "th"
		}
	}
}
