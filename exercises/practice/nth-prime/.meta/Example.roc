NthPrime :: {}.{
	prime : U64 -> Try(U64, [NoPrime0])
	prime = |number| {
		if number == 0 {
			Err(NoPrime0)
		} else if number == 1 {
			Ok(2)
		} else {
			find_prime = |primes, index| {
				if primes.len() == number {
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
					find_prime(new_primes, next_index)
				}
			}
			find_prime([2, 3], 3)
				.last()
				.map_err(
					|_| {
						crash "Unreachable: list cannot be empty"
					},
				)
		}
	}
}
