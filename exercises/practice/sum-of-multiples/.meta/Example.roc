SumOfMultiples :: {}.{
	sum_of_multiples : List(U64), U64 -> U64
	sum_of_multiples = |factors, limit| {
		factors
			.keep_if(
				|factor| factor > 0,
			)
			->join_map(|factor| (factor..<limit).step_by(factor))
			->Set.from_list()
			.to_list()
			.sum()
	}
}

# The following function should soon be available in Roc's builtins
join_map = |iter, func| {
	var $state = []
	for item in iter {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}
