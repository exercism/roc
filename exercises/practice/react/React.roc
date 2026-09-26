React :: {
	# TODO: change this opaque type however you need
	todo1 : U64,
	todo2 : U64,
	todo3 : U64,
	# etc.
}.{
	CellValue : I64
	CallbackLog : Dict(Str, List(CellValue))

	create : () -> React
	create = || {
		crash "Please implement the 'create' function"
	}

	add_input : React, { cell_id : Str, value : CellValue } -> Try(React, [DuplicateCell, ..])
	add_input = |reactor, input| {
		crash "Please implement the 'add_input' function"
	}

	add_compute : React, { cell_id : Str, inputs : List(Str), compute : List(CellValue) -> Try(CellValue, Str) } -> Try(React, [DuplicateCell, UnknownCell, ComputeFailed({ cell_id : Str, message : Str }), ..])
	add_compute = |reactor, cell| {
		crash "Please implement the 'add_compute' function"
	}

	value : React, Str -> Try(CellValue, [UnknownCell, ..])
	value = |reactor, cell_id| {
		crash "Please implement the 'value' function"
	}

	set_value : React, { cell_id : Str, value : CellValue, log : CallbackLog } -> Try({ reactor : React, log : CallbackLog }, [UnknownCell, NotInputCell, ComputeFailed({ cell_id : Str, message : Str }), ..])
	set_value = |reactor, update| {
		crash "Please implement the 'set_value' function"
	}

	add_callback : React, { cell_id : Str, callback_id : Str, callback : CellValue, CallbackLog -> CallbackLog } -> Try(React, [UnknownCell, NotComputeCell, DuplicateCallback, ..])
	add_callback = |reactor, registration| {
		crash "Please implement the 'add_callback' function"
	}

	remove_callback : React, { cell_id : Str, callback_id : Str } -> Try(React, [UnknownCell, NotComputeCell, ..])
	remove_callback = |reactor, registration| {
		crash "Please implement the 'remove_callback' function"
	}
}
