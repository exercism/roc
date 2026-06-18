PythagoreanTriplet :: {}.{
	Triplet : (U64, U64, U64)

	triplets_with_sum : U64 -> Set(Triplet)
	triplets_with_sum = |sum| {
		help = |triplets, a, b, sum2| {
			if a + b + b + 1 > sum2 {
				# c would have to be too small (≤ b)
				if 3 * (a + 1) > sum2 {
					# we can't increment a so we're done
					triplets
				} else {
					help(triplets, (a + 1), (a + 2), sum2) # increment a
				}
			} else {
				c = sum2 - a - b
				new_triplets = 
					if a * a + b * b == c * c {
						triplets.append((a, b, c)) # success!
					} else {
						triplets
					}
				help(new_triplets, a, (b + 1), sum2) # increment b
			}
		}
		help([], 1, 2, sum)->Set.from_list()
	}
}

# TODO: update once https://github.com/roc-lang/roc/issues/9690 is fixed
