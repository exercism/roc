IntergalacticTransmission :: {}.{
	transmit_sequence : List(U8) -> List(U8)
	transmit_sequence = |message| {
		if message == [] {
			return []
		}
		message.fold(
			{ result: [], left_over: 0, num_bits: 0 },
			|state, byte| {
				next_byte = state.left_over.bitwise_or(byte.shr_wrap(state.num_bits))
				result = state.result.append(set_parity_bit(next_byte))
				left_over = byte.shl_wrap(7 - state.num_bits)
				if state.num_bits < 6 {
					num_bits = state.num_bits + 1
					{ result, left_over, num_bits }
				} else {
					result2 = result.append(set_parity_bit(left_over))
					{ result: result2, left_over: 0, num_bits: 0 }
				}
			},
		)
			|> (|state| if state.num_bits == 0 {
				state.result
			} else {
				state.result.append(set_parity_bit(state.left_over))
			})
	}

	decode_message : List(U8) -> Try(List(U8), [WrongParity, ..])
	decode_message = |message| {
		decoded = message.fold(
			Ok({ result: [], next_byte: 0.U8, num_bits: 0 }),
			|acc, byte| {
				state = acc?
				if set_parity_bit(byte) != byte {
					Err(WrongParity)
				} else {
					Ok(
						[7, 6, 5, 4, 3, 2, 1].fold(
							state,
							|bits, shift| {
								bit = byte.shr_wrap(shift).bitwise_and(1)
								next_byte = bits.next_byte.shl_wrap(1).bitwise_or(bit)
								num_bits = bits.num_bits + 1
								if num_bits == 8 {
									{ result: bits.result.append(next_byte), next_byte: 0, num_bits: 0 }
								} else {
									{ result: bits.result, next_byte, num_bits }
								}
							},
						),
					)
				}
			},
		)?
		Ok(decoded.result)
	}
}

set_parity_bit : U8 -> U8
set_parity_bit = |byte| {
	sum = [1, 2, 3, 4, 5, 6, 7].fold(
		0,
		|count, shift| {
			count + byte.shr_wrap(shift).bitwise_and(1)
		},
	)
	byte.bitwise_and(0b11111110).bitwise_or(sum.bitwise_and(1))
}
