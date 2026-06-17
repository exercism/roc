Proverb :: {}.{
	recite : List(Str) -> Str
	recite = |strings| {
		match strings {
			[] => ""
			[first_thing, .. as rest] => {
				(_, lines) = 
					rest.fold(
						(first_thing, []),
						|(thing1, acc_lines), thing2| {
							(thing2, acc_lines.append("For want of a ${thing1} the ${thing2} was lost."))
						},
					)

				lines
					.append(
						"And all for the want of a ${first_thing}.",
					)
					->Str.join_with("\n")
			}
		}
	}
}
