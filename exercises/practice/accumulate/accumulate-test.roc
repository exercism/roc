# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/accumulate/canonical-data.json
# File last updated on 2026-06-09
app [main!] {
	pf: platform "https://github.com/lukewilliamboswell/roc-platform-template-zig/releases/download/0.7/DuRUyJh31Gt41YArMcVcvybLa2bCWboccWQ7Zq1KZPZ6.tar.zst",
}

import pf.Stdout

main! = |_args| {
	Ok({})
}

import Accumulate

# accumulate empty
expect {
	result = Accumulate.accumulate(
		[],
		|x| {
			x * x
		},
	)
	result == []
}

# accumulate squares
expect {
	result = Accumulate.accumulate(
		[1, 2, 3],
		|x| {
			x * x
		},
	)
	result == [1, 4, 9]
}

# accumulate upcases
expect {
	result = Accumulate.accumulate(["Hello", "world"], to_upper)
	result == ["HELLO", "WORLD"]
}

# accumulate reversed strings
expect {
	result = Accumulate.accumulate(["the", "quick", "brown", "fox", "etc"], reverse)
	result == ["eht", "kciuq", "nworb", "xof", "cte"]
}

# accumulate recursively
expect {
	result = Accumulate.accumulate(
		["a", "b", "c"],
		|x| {
			Accumulate.accumulate(
				["1", "2", "3"],
				|y| {
					Str.concat(x, y)
				},
			)
		},
	)
	result == [["a1", "a2", "a3"], ["b1", "b2", "b3"], ["c1", "c2", "c3"]]
}

reverse_list : List(a) -> List(a)
reverse_list = |list| {
	match list {
		[] => []
		[first, .. as rest] => reverse_list(rest).append(first)
	}
}

reverse : Str -> Str
reverse = |str| {
	str
		.to_utf8()
		->reverse_list()
		->Str.from_utf8()
		?? ""
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
