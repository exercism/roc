ArmstrongNumbers :: {}.{
	is_armstrong_number : U64 -> Bool
	is_armstrong_number = |number| {
		digits = list_digits(number)
		len = digits.len()
		candidate = 
			digits
				.map(
					|digit| {
						digit->pow_int(len)
					},
				)
				.sum()
		candidate == number
	}
}

list_digits : U64 -> List(U64)
list_digits = |number| {
	if number < 10 {
		[number]
	} else {
		list_digits((number // 10)).append((number % 10))
	}
}

# This function should soon be available in Roc's builtins
pow_int = |number, pow| {
	(1..=pow).fold(
		1,
		|acc, _| {
			acc * number
		},
	)
}
