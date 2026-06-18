PhoneNumber :: {}.{
	clean : Str -> Try(Str, [InvalidNumber])
	clean = |phone_number| {
		digits = 
			phone_number
				.to_utf8()
				.keep_if(|c| c >= '0' and c <= '9')

		num_digits = digits.len()
		if num_digits == 10 {
			check_number(digits)
		} else if num_digits == 11 {
			match digits {
				['1', .. as rest] => check_number(rest)
				_ => Err(InvalidNumber)
			}
		} else {
			Err(InvalidNumber)
		}
	}
}

check_number : List(U8) -> Try(Str, [InvalidNumber])
check_number = |digits| {
	match digits {
		[a1, _, _, e1, ..] if a1 == '0' or a1 == '1' or e1 == '0' or e1 == '1' => Err(InvalidNumber)
		_ => match Str.from_utf8(digits) {
			Ok(number) => Ok(number)
			Err(BadUtf8(_)) => {
				crash "Unreachable: a string of digits is valid UTF8"
			}
		}
	}
}
