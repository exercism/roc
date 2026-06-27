SquareRoot :: {}.{
	square_root : U64 -> U64
	square_root = |radicand| {
		binary_search = |min, max| {
			val = (min + max) // 2
			square = val * val
			if square == radicand or min >= max {
				val
			} else if square > radicand {
				binary_search(min, (val - 1))
			} else {
				binary_search((val + 1), max)
			}
		}

		binary_search(0, radicand)
	}
}
