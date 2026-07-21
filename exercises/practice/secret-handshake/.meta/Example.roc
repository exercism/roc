SecretHandshake :: {}.{
	commands : U64 -> List(Str)
	commands = |number| {
		actions = 
			[(1, "wink"), (2, "double blink"), (4, "close your eyes"), (8, "jump")]
				->join_map(
					|(mask, action)| {
						if U64.bitwise_and(number, mask) == 0 {
							[]
						} else {
							[action]
						}
					},
				)

		if U64.bitwise_and(number, 16) == 0 {
			actions
		} else {
			actions.rev()
		}
	}
}

# The following function should soon be available in Roc's builtins
join_map : i, (a -> j) -> List(b) where [i.iter : i -> Iter(a), j.iter : j -> Iter(b)]
join_map = |list, func| {
	var $state = []
	for item in list {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}
