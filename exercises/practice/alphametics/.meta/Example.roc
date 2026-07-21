Alphametics :: {}.{
	solve : Str -> Try(List((U8, U8)), [InvalidAssignment, ..])
	solve = |problem| {
		{ addends, sum } = parse(problem)?

		# We can represent the equation as a dictionary of the letters mapped to their coefficients
		# when we simplify the equation. For example, we can write AB + A + B == C as 11A + 2B + (-1)C == 0.
		# That then becomes this dictionary: `Dict.from_list([('A', 11), ('B', 2), ('C', -1)])
		equation : Dict(U8, I64)
		equation = {
			addends.fold(
				Dict.empty(),
				|dict, term| {
					dict->insert_term(term, 1)
				},
			)->insert_term(sum, -1)
		}

		leading_digits : Set(U8)
		leading_digits = {
			addends.map(
				|letters| {
					letters.first() ?? 0
				},
			)
				->Set.from_list()
				.insert(
					sum.first() ?? 0,
				)
		}

		find_match : List((U8, U8)), List(U8), Set(U8) -> Try(List((U8, U8)), [InvalidAssignment, ..])
		find_match = |assignments, remaining_vars, remaining_digits| {
			match remaining_vars {
				[] => {
					total_val : I64
					total_val = 
						assignments.fold(
							0,
							|total, (letter, value)| {
								(equation.get(letter) ?? 0) * value.to_i64() + total
							},
						)

					if total_val != 0 {
						Err(InvalidAssignment)
					} else {
						Ok(assignments)
					}
				}
				[letter, .. as rest] => {
					find_first_ok(
						remaining_digits,
						|digit| {
							if digit == 0 and leading_digits.contains(letter) {
								Err(InvalidAssignment)
							} else {
								# Each digit has to be unique, so once we use a digit we remove it from the pool
								find_match(assignments.append((letter, digit)), rest, remaining_digits.remove(digit))
							}
						},
					).map_err(|_| InvalidAssignment)
				}
			}
		}

		digits = Set.from_list([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
		find_match([], equation.keys(), digits)
	}
}

# Apply a function to each element of a list until the function returns an Ok, then return that value
find_first_ok : Set(a), (a -> Try(b, err)) -> Try(b, [NotFound])
find_first_ok = |set, func| {
	set.to_list().fold_until(
		Err(NotFound),
		|_, elem| {
			match func(elem) {
				Ok(result) => Break(Ok(result))
				_ => Continue(Err(NotFound))
			}
		},
	)
}

# Update the equation with the values of a term
insert_term : Dict(U8, I64), List(U8), I64 -> Dict(U8, I64)
insert_term = |equation, letters, polarity| {
	letters
		.rev()
		.fold_with_index(
			equation,
			|dict, letter, index| {
				coeff = pow_int(10, index) * polarity
				dict.update(
					letter,
					|val| {
						match val {
							Err(Missing) => Ok(coeff)
							Ok(c) => Ok((c + coeff))
						}
					},
				)
			},
		)
}

parse : Str -> Try({ addends : List(List(U8)), sum : List(U8) }, _)
parse = |problem| {
	{ before, after } = problem->split_first(" == ") ? |_| InvalidAssignment
	addends = 
		before
			.split_on(
				" + ",
			)
			.map(
				|s| {
					s.to_utf8()
				},
			)
	Ok({ addends, sum: after.to_utf8() })
}

reverse : Str -> Str
reverse = |str| {
	str
		.to_utf8()
		.rev()
		->Str.from_utf8()
		?? ""
}

# The following function should soon be available in Roc's builtins
split_first = |str, sep| {
	match str.split_on(sep) {
		[] => Err(NotFound)
		[_] => Err(NotFound)
		[before, .. as rest] => Ok({ before, after: rest->Str.join_with(sep) })
	}
}

pow_int = |number, pow| {
	(1..=pow).fold(
		1,
		|acc, _| {
			acc * number
		},
	)
}
