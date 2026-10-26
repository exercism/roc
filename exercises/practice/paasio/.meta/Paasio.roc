## Example solution

Paasio(state, err) :: { backend : Backend(state, err), statistics : Stats }.{
	Outcome(state, value, err) : { state : state, result : Try(value, err) }
	Backend(state, err) : {
		state : state,
		read! : state, U64 => Outcome(state, List(U8), err),
		write! : state, List(U8) => Outcome(state, U64, err),
	}
	Stats : {
		read_bytes : U64,
		read_operations : U64,
		write_bytes : U64,
		write_operations : U64,
	}

	create : Backend(state, err) -> Paasio(state, err)
	create = |backend| {
		{
			backend,
			statistics: { read_bytes: 0, read_operations: 0, write_bytes: 0, write_operations: 0 },
		}
	}

	stats : Paasio(state, err) -> Stats
	stats = |io| {
		io.statistics
	}

	get_state : Paasio(state, err) -> state
	get_state = |io| {
		io.backend.state
	}

	read! : Paasio(state, err), U64 => { io : Paasio(state, err), result : Try(List(U8), err) }
	read! = |io, max_bytes| {
		{ state, result } = (io.backend.read!)(io.backend.state, max_bytes)
		transferred = match result {
			Ok(bytes) => bytes.len()
			Err(_) => 0
		}
		statistics = {
			..io.statistics,
			read_bytes: io.statistics.read_bytes + transferred,
			read_operations: io.statistics.read_operations + 1,
		}
		{ io: { backend: { ..io.backend, state }, statistics }, result }
	}

	write! : Paasio(state, err), List(U8) => { io : Paasio(state, err), result : Try(U64, err) }
	write! = |io, bytes| {
		{ state, result } = (io.backend.write!)(io.backend.state, bytes)
		transferred = result ?? 0
		statistics = {
			..io.statistics,
			write_bytes: io.statistics.write_bytes + transferred,
			write_operations: io.statistics.write_operations + 1,
		}
		{ io: { backend: { ..io.backend, state }, statistics }, result }
	}
}
