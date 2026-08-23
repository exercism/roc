SecretHandshake :: {}.{
	commands : U64 -> List(Str)
	commands = |number| {
		actions =
			[(1, "wink"), (2, "double blink"), (4, "close your eyes"), (8, "jump")]
				.join_map(
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
