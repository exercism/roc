NthPrime :: {}.{
	prime : U64 -> Try(U64, [NoPrime0])
	prime = |number| {
		if number == 0 {
			Err(NoPrime0)
		} else if number == 1 {
			Ok(2)
		} else if number == 2 {
			Ok(3)
		} else {
			find_prime = |primes, index, number2| {
				if primes.len() == number2 {
					primes
				} else {
					next_index = index + 2
					new_primes = {
						if primes.any(|p| next_index % p == 0) {
							primes
						} else {
							primes.append(next_index)
						}
					}
					find_prime(new_primes, next_index, number2)
				}
			}
			find_prime([2, 3, 5], 5, number)
				.last()
				.map_err(
					|_| {
						crash "Unreachable: list cannot be empty"
					},
				)
		}
	}
}

# TODO: remove number2 once https://github.com/roc-lang/roc/issues/9690 is fixed
