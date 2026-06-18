PerfectNumbers :: {}.{
	classify : U64 -> Try([Abundant, Deficient, Perfect], [NumberArgIsZero])
	classify = |number| {
		sum = aliquot_sum(number)?
		if sum == number {
			Ok(Perfect)
		} else if sum > number {
			Ok(Abundant)
		} else {
			Ok(Deficient)
		}
	}
}

aliquot_sum : U64 -> Try(U64, [NumberArgIsZero])
aliquot_sum = |number| {
	if number == 0 {
		Err(NumberArgIsZero)
	} else if number == 1 {
		Ok(0)
	} else {
		(1..=(number // 2))
			.fold(
				0,
				|acc, d| if number % d == 0 {
					acc + d
				} else {
					acc
				},
			)
			->Ok()
	}
}
