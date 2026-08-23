SumOfMultiples :: {}.{
	sum_of_multiples : List(U64), U64 -> U64
	sum_of_multiples = |factors, limit| {
		(
			factors
				.keep_if(|factor| factor > 0)
				.join_map(|factor| (factor..<limit).step_by(factor).iter() |> List.from_iter)
				|> Set.from_list
		).to_list()
			.sum()
	}
}
