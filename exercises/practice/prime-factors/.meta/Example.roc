PrimeFactors :: {}.{
	prime_factors : U64 -> List(U64)
	prime_factors = |value| {
		find_prime_factors = |factors, n, p| {
			if n < 2 {
				factors
			} else if n->is_multiple_of(p) {
				find_prime_factors(factors.append(p), (n // p), p)
			} else if p * p < n {
				next_p = if p == 2 {
					3
				} else {
					p + 2
				}
				find_prime_factors(factors, n, next_p)
			} else {
				factors.append(n)
			}
		}

		find_prime_factors([], value, 2)
	}
}

is_multiple_of = |n, p| n % p == 0
