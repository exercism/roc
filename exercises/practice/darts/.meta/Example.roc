Darts :: {}.{
	score : F64, F64 -> U64
	score = |x, y| {
		d2 = distance_squared(x, y)
		if d2 > 100 {
			0
		} else if d2 > 25 {
			1
		} else if d2 > 1 {
			5
		} else {
			10
		}
	}
}

distance_squared = |x, y| {
	x * x + y * y
}
