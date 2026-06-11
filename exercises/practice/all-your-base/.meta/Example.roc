AllYourBase :: {}.{
	rebase : { input_base : U64, output_base : U64, digits : List(U64) } -> Try(List(U64), _)
	rebase = |{ input_base, output_base, digits }| {
		if input_base <= 1 {
			Err(InputBaseMustBeGreaterThanOne)
		} else if output_base <= 1 {
			Err(OutputBaseMustBeGreaterThanOne)
		} else if digits.any(
			|digit| {
				digit >= input_base
			},
		) {
			Err(DigitsMustBeLessThanInputBase)
		} else {
			number = digits.fold(
				0,
				|acc, digit| {
					acc * input_base + digit
				},
			)
			to_digits(number, output_base)->Ok
		}
	}
}

to_digits : U64, U64 -> List(U64)
to_digits = |number, base| {
	if number < base {
		[number]
	} else {
		to_digits(number // base, base).append(number % base)
	}
}
