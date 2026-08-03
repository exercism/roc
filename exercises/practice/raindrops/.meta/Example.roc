Raindrops :: {}.{
	convert : U64 -> Str
	convert = |number| {
		pling = if number % 3 == 0 {
			"Pling"
		} else {
			""
		}
		plang = if number % 5 == 0 {
			"Plang"
		} else {
			""
		}
		plong = if number % 7 == 0 {
			"Plong"
		} else {
			""
		}
		result = "${pling}${plang}${plong}"
		if result == "" {
			U64.to_str(number)
		} else {
			result
		}
	}
}
