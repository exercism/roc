# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/dominoes/canonical-data.json
# File last updated on 2026-06-19

import Dominoes exposing [Domino, find_chain]

# empty input = empty output
expect {
	dominoes = []
	result = find_chain(dominoes)
	result->is_valid_chain_for(dominoes)
}

# singleton input = singleton output
expect {
	dominoes = [
		(1, 1),
	]
	result = find_chain(dominoes)
	result->is_valid_chain_for(dominoes)
}

# singleton that can't be chained
expect {
	dominoes = [
		(1, 2),
	]
	result = find_chain(dominoes)
	result.is_err()
}

# three elements
expect {
	dominoes = [
		(1, 2),
		(3, 1),
		(2, 3),
	]
	result = find_chain(dominoes)
	result->is_valid_chain_for(dominoes)
}

# can reverse dominoes
expect {
	dominoes = [
		(1, 2),
		(1, 3),
		(2, 3),
	]
	result = find_chain(dominoes)
	result->is_valid_chain_for(dominoes)
}

# can't be chained
expect {
	dominoes = [
		(1, 2),
		(4, 1),
		(2, 3),
	]
	result = find_chain(dominoes)
	result.is_err()
}

# disconnected - simple
expect {
	dominoes = [
		(1, 1),
		(2, 2),
	]
	result = find_chain(dominoes)
	result.is_err()
}

# disconnected - double loop
expect {
	dominoes = [
		(1, 2),
		(2, 1),
		(3, 4),
		(4, 3),
	]
	result = find_chain(dominoes)
	result.is_err()
}

# disconnected - single isolated
expect {
	dominoes = [
		(1, 2),
		(2, 3),
		(3, 1),
		(4, 4),
	]
	result = find_chain(dominoes)
	result.is_err()
}

# need backtrack
expect {
	dominoes = [
		(1, 2),
		(2, 3),
		(3, 1),
		(2, 4),
		(2, 4),
	]
	result = find_chain(dominoes)
	result->is_valid_chain_for(dominoes)
}

# separate loops
expect {
	dominoes = [
		(1, 2),
		(2, 3),
		(3, 1),
		(1, 1),
		(2, 2),
		(3, 3),
	]
	result = find_chain(dominoes)
	result->is_valid_chain_for(dominoes)
}

# nine elements
expect {
	dominoes = [
		(1, 2),
		(5, 3),
		(3, 1),
		(1, 2),
		(2, 4),
		(1, 6),
		(2, 3),
		(3, 4),
		(5, 6),
	]
	result = find_chain(dominoes)
	result->is_valid_chain_for(dominoes)
}

# separate three-domino loops
expect {
	dominoes = [
		(1, 2),
		(2, 3),
		(3, 1),
		(4, 5),
		(5, 6),
		(6, 4),
	]
	result = find_chain(dominoes)
	result.is_err()
}

# # Compare two dominoes in lexicographical order, for example (3, 1) > (2, 5)
compare_dominoes : (U8, U8), (U8, U8) -> [LT, GT, EQ]
compare_dominoes = |a, b| {
	if a.0 < b.0 {
		LT
	} else if a.0 > b.0 {
		GT
	} else
		if a.1 < b.1 {
			LT
		} else if a.1 > b.1 {
			GT
		} else {
			EQ
		}
}

# # Rotate each domino if needed to ensure that the small side is on the left
# # then sort the dominoes in lexicographical order
canonicalize : List((U8, U8)) -> List((U8, U8))
canonicalize = |dominoes| {
	maybe_flip : (U8, U8) -> (U8, U8)
	maybe_flip = |domino| {
		if domino.0 > domino.1 (domino.1, domino.0) else domino
	}
	dominoes.map(maybe_flip).sort_with(compare_dominoes)
}

# # Checks whether the list of dominoes forms a valid chain
is_valid_chain = |dominoes| {
	match dominoes {
		[] => Bool.True
		[(first_left, first_right), .. as rest] => {
			var $previous = first_right
			for (next_left, next_right) in rest {
				if $previous != next_left {
					return Bool.False
				}
				$previous = next_right
			}
			$previous == first_left
		}
	}
}

# # Check whether the given chain (if Ok) is valid and corresponds to the given
# # list of dominoes
is_valid_chain_for = |maybe_chain, dominoes| {
	match maybe_chain {
		Ok(chain) => (canonicalize(chain) == canonicalize(dominoes)) and is_valid_chain(chain)
		Err(_) => Bool.False
	}
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
