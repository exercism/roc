# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/accumulate/canonical-data.json
# File last updated on 2026-06-13

import Accumulate exposing [accumulate]

# accumulate empty
expect {
	result = accumulate(
		[],
		|x| {
			x * x
		},
	)
	result == []
}

# accumulate squares
expect {
	result = accumulate(
		[1, 2, 3],
		|x| {
			x * x
		},
	)
	result == [1, 4, 9]
}

# accumulate upcases
expect {
	result = accumulate(["Hello", "world"], to_upper)
	result == ["HELLO", "WORLD"]
}

# accumulate reversed strings
expect {
	result = accumulate(["the", "quick", "brown", "fox", "etc"], str_reverse)
	result == ["eht", "kciuq", "nworb", "xof", "cte"]
}

# accumulate recursively
expect {
	result = accumulate(
		["a", "b", "c"],
		|x| {
			accumulate(
				["1", "2", "3"],
				|y| {
					Str.concat(x, y)
				},
			)
		},
	)
	result == [["a1", "a2", "a3"], ["b1", "b2", "b3"], ["c1", "c2", "c3"]]
}

to_upper_char : U8 -> U8
to_upper_char = |byte| {
	if 'a' <= byte and byte <= 'z' {
		byte - 'a' + 'A'
	} else {
		byte
	}
}

to_upper : Str -> Str
to_upper = |str| {
	str.to_utf8().map(to_upper_char)->Str.from_utf8() ?? ""
}

str_reverse : Str -> Str
str_reverse = |str| {
	str
		.to_utf8()
		->reverse()
		->Str.from_utf8()
		?? ""
}

# List.reverse should soon be available in Roc's builtins
reverse : List(a) -> List(a)
reverse = |list| {
	match list {
		[] => []
		[first, .. as rest] => reverse(rest).append(first)
	}
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
