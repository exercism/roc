ArmstrongNumbers :: {}.{
	is_armstrong_number : U64 -> Bool
	is_armstrong_number = |number| {
		digits = list_digits(number)
		len = digits.len()
		candidate = 
			digits
				.map(
					|digit| {
						digit.pow(len)
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
