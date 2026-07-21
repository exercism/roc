CircularBuffer :: { data : List(I64), start : U64, length : U64 }.{
	create : { capacity : U64 } -> CircularBuffer
	create = |{ capacity }| {
		{ data: List.repeat(0, capacity), start: 0, length: 0 }
	}

	read : CircularBuffer -> Try({ updated_buffer : CircularBuffer, value : I64 }, [BufferEmpty])
	read = |{ data, start, length }| {
		if length == 0 {
			Err(BufferEmpty)
		} else {
			increment_start = (start + 1) % data.len()
			updated_buffer = { data, start: increment_start, length: length - 1 }
			match data.get(start) {
				Ok(value) => Ok({ updated_buffer, value })
				Err(OutOfBounds) => {
					crash "Unreachable: start should never be out of bounds"
				}
			}
		}
	}

	write : CircularBuffer, I64 -> Try(CircularBuffer, [BufferFull])
	write = |{ data, start, length }, value| {
		if length == data.len() {
			Err(BufferFull)
		} else {
			index = (start + length) % data.len()
			new_data = match data.replace(index, value) {
				Ok(d) => d
				Err(_) => {
					crash "Unreachable: the index is guaranteed to be within bounds."
				}
			}.list
			Ok({ data: new_data, start, length: length + 1 })
		}
	}

	overwrite : CircularBuffer, I64 -> CircularBuffer
	overwrite = |{ data, start, length }, value| {
		index = (start + length) % data.len()
		new_data = match data.replace(index, value) {
			Ok(d) => d
			Err(_) => {
				crash "Unreachable: the index is guaranteed to be within bounds."
			}
		}.list
		if length == data.len() {
			inc_start = (start + 1) % data.len()
			{ data: new_data, start: inc_start, length: length }
		} else {
			{ data: new_data, start, length: length + 1 }
		}
	}

	clear : CircularBuffer -> CircularBuffer
	clear = |circular_buffer| {
		{ data: circular_buffer.data, start: 0, length: 0 }
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _
}
