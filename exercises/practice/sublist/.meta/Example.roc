Sublist :: {}.{
	sublist : List(U8), List(U8) -> [Equal, Sublist, Superlist, Unequal]
	sublist = |list1, list2| {
		match list1.len()->compare(list2.len()) {
			GT => {
				match sublist(list2, list1) {
					Sublist => Superlist
					Unequal => Unequal
					Superlist => {
						crash "Unreachable: list 2 is shorter than list 1"
					}
					Equal => {
						crash "Unreachable: list 1 and 2 don't have the same length"
					}
				}
			}

			EQ => {
				if list1 == list2 {
					Equal
				} else {
					Unequal
				}
			}

			LT => {
				length_diff = list2.len() - list1.len()
				maybe_equal_index = 
					(0..=length_diff)
						.fold([], |acc, x| acc.append(x))
						.find_first(
							|start| {
								list2
									.sublist({ start, len: list1.len() })
									== list1
							},
						)

				match maybe_equal_index {
					Ok(_) => Sublist
					Err(NotFound) => Unequal
				}
			}
		}
	}
}

# The following function should soon be available in Roc's builtins
compare = |a, b| {
	if a < b {
		LT
	} else if a > b {
		GT
	} else {
		EQ
	}
}
