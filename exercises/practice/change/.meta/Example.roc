Change :: {}.{
	find_fewest_coins : List(U64), U64 -> Try(List(U64), [NotFound])
	find_fewest_coins = |coins, target| {
		help = |sorted_coins, sub_target, max_length| {
			if sub_target == 0 {
				Ok([])
			} else if max_length == 0 {
				Err(NotFound)
			} else {
				match sorted_coins {
					[] => Err(NotFound)
					[largest_coin, .. as other_coins] => {
						if largest_coin == sub_target {
							Ok([largest_coin])
						} else if largest_coin < sub_target {
							match help(sorted_coins, (sub_target - largest_coin), (max_length - 1)) {
								Ok(other_coins_with) => {
									coins_with = other_coins_with.append(largest_coin)
									match help(other_coins, sub_target, (coins_with.len() - 1)) {
										Ok(coins_without) => Ok(coins_without)
										Err(NotFound) => Ok(coins_with)
									}
								}
								Err(NotFound) => help(other_coins, sub_target, max_length)
							}
						} else {
							help(other_coins, sub_target, max_length)
						}
					}
				}
			}
		}

		help(coins->sort_desc(), target, U64.highest)?
	}
		->sort_asc()
		->Ok()
}

# The following functions should soon be available in Roc's builtins
sort_asc = |list| {
	list.sort_with(|a, b| a.compare(b))
}

sort_desc = |list| {
	list.sort_with(|a, b| b.compare(a))
}
