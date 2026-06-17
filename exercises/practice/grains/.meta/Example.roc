Grains :: {}.{
	grains_on_square : U8 -> Try(U64, [SquareArgWasNotBetween1And64(U8)])
	grains_on_square = |square| {
		if square > 0 and square <= 64 {
			Ok(2->pow_int(square.to_u64() - 1))
		} else {
			Err(SquareArgWasNotBetween1And64(square))
		}
	}

	total_grains : U64
	total_grains = max_u64
}

# This function should soon be available in Roc's builtins
pow_int : U64, U64 -> U64
pow_int = |number, pow| {
	(1..=pow).fold(
		1,
		|acc, _| {
			acc * number
		},
	)
}

max_u64 = 18_446_744_073_709_551_615
