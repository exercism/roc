Paasio(state, err) :: {
	# TODO: change this opaque type however you need
	todo : U64,
}.{
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
		crash "Please implement the 'create' function"
	}

	stats : Paasio(state, err) -> Stats
	stats = |io| {
		crash "Please implement the 'stats' function"
	}

	get_state : Paasio(state, err) -> state
	get_state = |io| {
		crash "Please implement the 'get_state' function"
	}

	read! : Paasio(state, err), U64 => { io : Paasio(state, err), result : Try(List(U8), err) }
	read! = |io, max_bytes| {
		crash "Please implement the 'read!' function"
	}

	write! : Paasio(state, err), List(U8) => { io : Paasio(state, err), result : Try(U64, err) }
	write! = |io, bytes| {
		crash "Please implement the 'write!' function"
	}
}
