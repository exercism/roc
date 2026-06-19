Luhn :: {}.{
	valid : Str -> Bool
	valid = |number| {
		match to_digits(number) {
			Ok(digits) if digits.len() > 1 => {
				sum = map_every_other_backwards(
					digits,
					|digit| {
						product = digit * 2
						if product < 10 {
							product
						} else {
							product - 9
						}
					},
				).sum()
				sum % 10 == 0
			}
			_ => Bool.False
		}
	}
}

to_digits : Str -> Try(List(U16), [IllegalCharacter])
to_digits = |number| {
	help : List(U8), List(U16) -> Try(List(U16), [IllegalCharacter])
	help = |input, digits| {
		match input {
			[] => Ok(digits)
			[byte, .. as rest] if byte == ' ' => help(rest, digits)
			[byte, .. as rest] if '0' <= byte and byte <= '9' => {
				digit = (byte - '0').to_u16()
				help(rest, digits.append(digit))
			}
			_ => Err(IllegalCharacter)
		}
	}
	help(number.to_utf8(), [])
}

map_every_other_backwards : List(a), (a -> a) -> List(a)
map_every_other_backwards = |list, func| {
	help = |state, input| {
		match input {
			[.. as rest, x, y] => {
				state
					.append(y)
					.append(func(x))
					->help(rest)
			}

			[x] => state.append(x)
			[] => state
		}
	}
	help([], list)->reverse()
}

# List.reverse should soon be available in Roc's builtins
reverse : List(a) -> List(a)
reverse = |list| {
	match list {
		[] => []
		[first, .. as rest] => reverse(rest).append(first)
	}
}
