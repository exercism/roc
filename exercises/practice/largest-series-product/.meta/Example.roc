LargestSeriesProduct :: {}.{
	largest_product : Str, U64 -> Try(U64, [SpanWasTooLarge, InvalidDigit])
	largest_product = |digits, span| {
		if span == 0 {
			Ok(1)
		} else {
			chars = digits.to_utf8()
			if chars.len() < span {
				Err(SpanWasTooLarge)
			} else if chars.any(|char| char < '0' or char > '9') {
				Err(InvalidDigit)
			} else {
				(0..=(chars.len() - span))
					.map(
						|start_index| {
							chars
								.sublist(
									{ start: start_index, len: span },
								)
								.fold(
									1,
									|product, char| {
										product * (char - '0').to_u64()
									},
								)
						},
					)
					->List.from_iter()
					.max() # TODO: replace with Iter.max when available
					.map_err(
						|_| {
							crash "Unreachable: the list cannot be empty here"
						},
					)
			}
		}
	}
}
