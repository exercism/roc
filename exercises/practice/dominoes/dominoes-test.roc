# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/dominoes/canonical-data.json
# File last updated on 2026-06-13

import Dominoes exposing [Domino, find_chain]

## Rotate each domino if needed to ensure that the small side is on the left
canonicalize : List(Domino) -> List(Domino)
canonicalize = |dominoes| {
	dominoes
		.map(
			|domino| {
				if domino.0 > domino.1 (domino.1, domino.0) else domino
			},
		)
}

## Ensure that the given result is Ok and is a valid chain for the
## given list of dominoes
is_valid_chain_for : Try(List(Domino), _), List(Domino) -> Bool
is_valid_chain_for = |maybe_chain, dominoes| {
	match maybe_chain {
		Err(_) => Bool.False
		Ok(chain) => {
			if Set.from_list(canonicalize(chain)) == Set.from_list(canonicalize(dominoes)) {
				match chain {
					[] => Bool.True
					[.., last] => {
						chain
							.fold_until(
								Ok(last),
								|state, domino| {
									match state {
										Err(InvalidChain) => {
											crash "Unreachable"
										}
										Ok(previous) => {
											if previous.1 == domino.0 {
												Continue(Ok(domino))
											} else {
												Break(Err(InvalidChain))
											}
										}
									}
								},
							)
							.is_ok()
					}
				}
			} else {
				Bool.False
			}
		}
	}
}

# empty input = empty output
expect {
	result = Domino.find_chain([])
	result->is_valid_chain_for([])
}

# singleton input = singleton output
expect {
	result = Domino.find_chain(
		[
			(1, 1),
		],
	)
	result->is_valid_chain_for(
		[
			(1, 1),
		],
	)
}

# singleton that can't be chained
expect {
	result = Domino.find_chain(
		[
			(1, 2),
		],
	)
	result.is_err()
}

# three elements
expect {
	result = Domino.find_chain(
		[
			(1, 2),
			(3, 1),
			(2, 3),
		],
	)
	result->is_valid_chain_for(
		[
			(1, 2),
			(3, 1),
			(2, 3),
		],
	)
}

# can reverse dominoes
expect {
	result = Domino.find_chain(
		[
			(1, 2),
			(1, 3),
			(2, 3),
		],
	)
	result->is_valid_chain_for(
		[
			(1, 2),
			(1, 3),
			(2, 3),
		],
	)
}

# can't be chained
expect {
	result = Domino.find_chain(
		[
			(1, 2),
			(4, 1),
			(2, 3),
		],
	)
	result.is_err()
}

# disconnected - simple
expect {
	result = Domino.find_chain(
		[
			(1, 1),
			(2, 2),
		],
	)
	result.is_err()
}

# disconnected - double loop
expect {
	result = Domino.find_chain(
		[
			(1, 2),
			(2, 1),
			(3, 4),
			(4, 3),
		],
	)
	result.is_err()
}

# disconnected - single isolated
expect {
	result = Domino.find_chain(
		[
			(1, 2),
			(2, 3),
			(3, 1),
			(4, 4),
		],
	)
	result.is_err()
}

# need backtrack
expect {
	result = Domino.find_chain(
		[
			(1, 2),
			(2, 3),
			(3, 1),
			(2, 4),
			(2, 4),
		],
	)
	result->is_valid_chain_for(
		[
			(1, 2),
			(2, 3),
			(3, 1),
			(2, 4),
			(2, 4),
		],
	)
}

# separate loops
expect {
	result = Domino.find_chain(
		[
			(1, 2),
			(2, 3),
			(3, 1),
			(1, 1),
			(2, 2),
			(3, 3),
		],
	)
	result->is_valid_chain_for(
		[
			(1, 2),
			(2, 3),
			(3, 1),
			(1, 1),
			(2, 2),
			(3, 3),
		],
	)
}

# nine elements
expect {
	result = Domino.find_chain(
		[
			(1, 2),
			(5, 3),
			(3, 1),
			(1, 2),
			(2, 4),
			(1, 6),
			(2, 3),
			(3, 4),
			(5, 6),
		],
	)
	result->is_valid_chain_for(
		[
			(1, 2),
			(5, 3),
			(3, 1),
			(1, 2),
			(2, 4),
			(1, 6),
			(2, 3),
			(3, 4),
			(5, 6),
		],
	)
}

# separate three-domino loops
expect {
	result = Domino.find_chain(
		[
			(1, 2),
			(2, 3),
			(3, 1),
			(4, 5),
			(5, 6),
			(6, 4),
		],
	)
	result.is_err()
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
