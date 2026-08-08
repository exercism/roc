RomanNumerals :: {}.{
	roman : U64 -> Try(Str, [InvalidNumber(U64)])
	roman = |number| {
		if number == 0 or number > 3999 {
			Err(InvalidNumber(number))
		} else {
			convert = |digit, x1, x5, x10| {
				match digit {
					4 => "${x1}${x5}"
					9 => "${x1}${x10}"
					n => {
						if n <= 3 {
							x1.repeat(n)
						} else {
							"${x5}${x1.repeat(n - 5)}"
						}
					}
				}
			}
			thousands = convert(number // 1000, "M", "?", "?")
			hundreds = convert((number % 1000) // 100, "C", "D", "M")
			tens = convert((number % 100) // 10, "X", "L", "C")
			units = convert(number % 10, "I", "V", "X")
			Ok("${thousands}${hundreds}${tens}${units}")
		}
	}
}
