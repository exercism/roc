RunLengthEncoding :: {}.{
	encode : Str -> Try(Str, [BadUtf8(_), ..])
	encode = |string| {
		append_count_and_letter = |state| {
			match state.count {
				0 => []
				1 => state.chars.append(state.last_char)
				_ => {
					digits = state.count.to_str().to_utf8()
					state.chars.concat(digits).append(state.last_char)
				}
			}
		}

		string
			.to_utf8()
			.fold(
				{ chars: [], last_char: 0.U8, count: 0.U64 },
				|state, char| {
					if state.count == 0 {
						{ chars: [], last_char: char, count: 1 }
					} else if state.last_char == char {
						{ ..state, count: state.count + 1 }
					} else {
						chars = append_count_and_letter(state)
						{ chars, last_char: char, count: 1 }
					}
				},
			)
			->append_count_and_letter()
			->Str.from_utf8()
	}

	decode : Str -> Try(Str, [BadUtf8(_), BadNumStr, ..])
	decode = |string| {
		state_to_str = |state| state.chars->Str.from_utf8()
		string
			.to_utf8()
			->fold_try(
				{ chars: [], digits: [] },
				|state, char| {
					if char >= '0' and char <= '9' {
						digits = state.digits.append(char)
						Ok({ ..state, digits })
					} else if state.digits == [] {
						chars = state.chars.append(char)
						Ok({ ..state, chars })
					} else {
						count_str = state.digits->Str.from_utf8()?
						count = count_str->U64.from_str()?
						chars = state.chars.concat(char->List.repeat(count))
						Ok({ chars, digits: [] })
					}
				},
			)?
			->state_to_str()

	}
}

# The following function should soon be available in Roc's builtins
fold_try : List(a), b, (b, a -> Try(b, err)) -> Try(b, err)
fold_try = |list, init, func| {
	list.fold_until(
		Ok(init),
		|state, item| {
			match state {
				Ok(internal_state) => {
					match func(internal_state, item) {
						Ok(new_state) => Continue(Ok(new_state))
						Err(final_err) => Break(Err(final_err))
					}
				}
				Err(_) => {
					crash "Unreachable"
				}
			}
		},
	)
}
