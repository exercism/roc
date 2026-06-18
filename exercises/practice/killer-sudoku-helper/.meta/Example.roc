KillerSudokuHelper :: {}.{
	Combination : List(U8)

	combinations : { sum : U8, size : U8, exclude : List(U8) } -> List(Combination)
	combinations = |{ sum, size, exclude }| {
		help = |target, digits| {
			if target == 0 {
				[[]]
			} else {
				match digits {
					[] => []
					[single] => {
						if single == target {
							[[single]]
						} else {
							[]
						}
					}
					[first, .. as rest] => {
						if first > target {
							[]
						} else {
							help((target - first), rest)
								.map(
									|combi| combi.append(first),
								)
								.concat(
									help(target, rest),
								)
						}
					}
				}
			}
		}
		available_digits = 
			[1, 2, 3, 4, 5, 6, 7, 8, 9]
				.drop_if(
					|digit| exclude.contains(digit),
				)
		help(sum, available_digits)
			.keep_if(
				|combi| combi.len() == size.to_u64(),
			)
			.map(
				reverse,
			)
	}
}

# List.reverse should soon be available in Roc's builtins
reverse : List(a) -> List(a)
reverse = |list| {
	match list {
		[] => []
		[first, .. as rest] => reverse(rest).append(first)
	}
}
