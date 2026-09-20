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
		var $result = []
		var $next_byte = 0.U8
		var $num_bits = 0
		for byte in message {
			if set_parity_bit(byte) != byte {
				return Err(WrongParity)
			}
			for offset in 0..<7 {
				bit = byte.shr_wrap(7 - offset).bitwise_and(1)
				$next_byte = $next_byte.shl_wrap(1).bitwise_or(bit)
				$num_bits = $num_bits + 1
				if $num_bits == 8 {
					$result = $result.append($next_byte)
					$next_byte = 0
					$num_bits = 0
				}
			}
		}
		Ok($result)
	}
}

set_parity_bit : U8 -> U8
set_parity_bit = |byte| {
	var $res = byte
	var $sum = 0
	for _ in 1..=7 {
		$res = $res.shr_wrap(1)
		$sum = $sum + $res.bitwise_and(1)
	}
	byte.bitwise_and(0b11111110).bitwise_or($sum.bitwise_and(1))
}
