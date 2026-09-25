##
## Example solution
##

BookStore :: {}.{
	total : List(U8) -> Dec
	total = |basket| {
		unit_price = 8
		total_in_series = basket
			|> count_books_in_series
			.sort()
			|> differences
			|> rebalance_groups
			.map2([5, 4, 3, 2, 1], |books_in_group, groups| (books_in_group * groups).to_dec() * unit_price)
			.map2([0.25, 0.20, 0.10, 0.05, 0.00], |base_price, discount| base_price * (1 - discount))
			.sum()
		total_not_in_series = basket.keep_if(|id| id < 1 or id > 5).len().to_dec() * unit_price
		total_in_series + total_not_in_series
	}
}

count_books_in_series : List(U8) -> List(U64)
count_books_in_series = |basket| {
	basket
		.fold(
			[0, 0, 0, 0, 0],
			|state, id| {
				if id >= 1 and id <= 5 {
					state.update(id.to_u64() - 1, |v| v + 1)
						?? {
							crash "Unreachable: index must be in bounds"
						}
				} else {
					state
				}
			},
		)
}

rebalance_groups : List(U64) -> List(U64)
rebalance_groups = |groups| {
	match groups {
		[fives, fours, threes, twos, ones] => {
			# A group of five plus a group of three costs 51.60, but
			# redistributing them into two groups of four costs 51.20.
			pairs = if fives < threes {
				fives
			} else {
				threes
			}
			[fives - pairs, fours + 2 * pairs, threes - pairs, twos, ones]
		}
		_ => crash "Unreachable: expected five group counts"
	}
}

differences : List(U64) -> List(U64)
differences = |values| {
	result = values.fold(
		{ previous: 0.U64, differences: [] },
		|acc, value| {
			{
				previous: value,
				differences: acc.differences.append(value - acc.previous),
			}
		},
	)
	result.differences
}
