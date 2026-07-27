Grains :: {}.{
	grains_on_square : U8 -> Try(U64, [SquareArgWasNotBetween1And64(U8)])
	grains_on_square = |square| {
		if square > 0 and square <= 64 {
			Ok((2.U64).pow(square.to_u64() - 1))
		} else {
			Err(SquareArgWasNotBetween1And64(square))
		}
	}

	total_grains : U64
	total_grains = U64.highest
}
