Sieve :: {}.{
	primes : U64 -> List(U64)
	primes = |limit| {
		if limit < 2 {
			[]
		} else {
			help_sieve = |candidates, found_primes| {
				match candidates {
					[] => found_primes
					[0, .. as rest] => {
						help_sieve(rest, found_primes)
					}
					[prime, .. as rest] => {
						((prime * 2)..=limit).step_by(prime)
							.fold(
								rest,
								|filtered_candidates, multiple_of_prime| {
									match filtered_candidates.replace(multiple_of_prime - prime - 1, 0) {
										Ok(result) => result.list
										Err(_) => {
											crash "Unreachable"
										}
									}
								},
							)
							->help_sieve(found_primes.append(prime))
					}
				}
			}

			initial_candidates = List.from_iter(2..=limit)
			help_sieve(initial_candidates, [])
		}
	}
}
