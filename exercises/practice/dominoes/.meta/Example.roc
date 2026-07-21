Dominoes :: {}.{
	Domino : (U8, U8)

	find_chain : List(Domino) -> Try(List(Domino), [NoChainExists])
	find_chain = |dominoes| {
		find_chain_helper = |used, available| {
			match available {
				[] => match used {
					[] => Ok([])
					[(single_left, single_right)] =>
						if single_left == single_right Ok(used) else Err(NoChainExists)
					[(first_left, _), .., (_, last_right)] =>
						if first_left == last_right Ok(used) else Err(NoChainExists)
					}
				[first_available, .. as rest_available] => match used {
					[] => find_chain_helper([first_available], rest_available)
					[.., (_, last_used_right)] => {
						available
							.fold_with_index_until(
								Err(NoChainExists),
								|_, (domino_left, domino_right), index| {
									maybe_chain = 
										if last_used_right == domino_left {
											find_chain_helper(used.append((domino_left, domino_right)), available.drop_at(index))
										} else if last_used_right == domino_right {
											find_chain_helper(used.append((domino_right, domino_left)), available.drop_at(index))
										} else {
											Err(NoChainExists)
										}
									match maybe_chain {
										Ok(chain) => Break(Ok(chain))
										Err(NoChainExists) => Continue(Err(NoChainExists))
									}
								},
							)
					}
				}
			}
		}

		find_chain_helper([], dominoes)
	}
}
