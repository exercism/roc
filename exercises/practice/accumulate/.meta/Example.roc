Accumulate :: {}.{
	accumulate : List(a), (a -> b) -> List(b)
	accumulate = |list, func| {
		help = |output, input| {
			match input {
				[] => output
				[first, .. as rest] => output.append(func(first))->help(rest)
			}
		}
		help([], list)
	}
}
