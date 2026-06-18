MatchingBrackets :: {}.{
	is_paired : Str -> Bool
	is_paired = |string| {
		is_open = |c| {
			c == '[' or c == '(' or c == '{'
		}
		is_close = |c| {
			c == ']' or c == ')' or c == '}'
		}
		is_match = |pair| {
			pair == ('[', ']') or pair == ('(', ')') or pair == ('{', '}')
		}
		help = |open_brackets, remaining_chars| {
			match remaining_chars {
				[] => open_brackets.is_empty()
				[next_char, .. as rest_chars] => {
					if is_open(next_char) {
						help(open_brackets.append(next_char), rest_chars)
					} else if is_close(next_char) {
						match open_brackets {
							[] => Bool.False
							[.. as previous_opens, last_open] => {
								if is_match((last_open, next_char)) {
									help(previous_opens, rest_chars)
								} else {
									Bool.False
								}
							}
						}
					} else {
						help(open_brackets, rest_chars)
					}
				}
			}
		}

		help([], string.to_utf8())
	}
}
