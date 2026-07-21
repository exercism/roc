PascalsTriangle :: {}.{
	pascals_triangle : U64 -> List(List(U64))
	pascals_triangle = |count| {
		(0..<count)
			.map(
				|row| {
					(0..=row)
						.map(
							|column| binomial_coefficient(row, column),
						)
						->List.from_iter()
				},
			)
			->List.from_iter()
	}
}

binomial_coefficient : U64, U64 -> U64
binomial_coefficient = |n, k| {
	if k == 0 or k == n {
		1
	} else {
		numerator = 
			((n + 1 - k)..=n)
				.fold(
					1,
					|product, value| product * value,
				)
		denominator = 
			(1..=k)
				.fold(
					1,
					|product, value| product * value,
				)
		numerator // denominator
	}
}
