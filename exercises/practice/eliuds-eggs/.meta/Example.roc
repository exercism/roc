EliudsEggs :: {}.{
	egg_count : U64 -> U64
	egg_count = |number| {
		help = |count, remaining| {
			if remaining == 0 {
				count
			} else {
				digit = remaining % 2
				help((count + digit), (remaining // 2))
			}
		}

		help(0, number)
	}
}
