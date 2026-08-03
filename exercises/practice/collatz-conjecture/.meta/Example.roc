CollatzConjecture :: {}.{
	steps : U64 -> Try(U64, [NumberArgWasZero, ..])
	steps = |number| {
		if number <= 0 {
			Err(NumberArgWasZero)
		} else if number == 1 {
			Ok(0)
		} else if number % 2 == 0 {
			Ok(steps(number // 2)? + 1)
		} else {
			Ok(steps(3 * number + 1)? + 1)
		}
	}
}
