SquareRoot :: {}.{
	square_root : U64 -> U64
	square_root = |radicand| {
		binary_search = |min, max, target_square| {
			val = (min + max) // 2
			square = val * val
			if square == target_square or min >= max {
				val
			} else if square > target_square {
				binary_search(min, (val - 1), target_square)
			} else {
				binary_search((val + 1), max, target_square)
			}
		}

		binary_search(0, radicand, radicand)
	}
}

# TODO: update once https://github.com/roc-lang/roc/issues/9690 is fixed
