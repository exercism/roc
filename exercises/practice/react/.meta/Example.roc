React :: {
	values : Dict(Str, CellValue),
	inputs : Set(Str),
	computations : List({ cell_id : Str, inputs : List(Str), compute : List(CellValue) -> Try(CellValue, Str) }),
	callbacks : List({ cell_id : Str, callback_id : Str, callback : CellValue, CallbackLog -> CallbackLog }),
}.{
	CellValue : I64
	CallbackLog : Dict(Str, List(CellValue))

	create : () -> React
	create = || {
		{ values: Dict.empty(), inputs: Set.empty(), computations: [], callbacks: [] }
	}

	add_input : React, { cell_id : Str, value : CellValue } -> Try(React, [DuplicateCell, ..])
	add_input = |reactor, input| {
		if reactor.values.get(input.cell_id).is_ok() {
			Err(DuplicateCell)
		} else {
			Ok({
				..reactor,
				values: reactor.values.insert(input.cell_id, input.value),
				inputs: reactor.inputs.insert(input.cell_id),
			})
		}
	}

	add_compute : React, { cell_id : Str, inputs : List(Str), compute : List(CellValue) -> Try(CellValue, Str) } -> Try(React, [DuplicateCell, UnknownCell, ComputeFailed({ cell_id : Str, message : Str }), ..])
	add_compute = |reactor, cell| {
		if reactor.values.get(cell.cell_id).is_ok() {
			Err(DuplicateCell)
		} else {
			values = cell.inputs.map_try(|input_id| reactor.value(input_id))?
			computed = (cell.compute)(values) ? |message| ComputeFailed({ cell_id: cell.cell_id, message })
			Ok({
				..reactor,
				values: reactor.values.insert(cell.cell_id, computed),
				computations: reactor.computations.append(cell),
			})
		}
	}

	value : React, Str -> Try(CellValue, [UnknownCell, ..])
	value = |reactor, cell_id| {
		reactor.values.get(cell_id).map_err(|KeyNotFound| UnknownCell)
	}

	set_value : React, { cell_id : Str, value : CellValue, log : CallbackLog } -> Try({ reactor : React, log : CallbackLog }, [UnknownCell, NotInputCell, ComputeFailed({ cell_id : Str, message : Str }), ..])
	set_value = |reactor, update| {
		previous = reactor.value(update.cell_id)?
		if !reactor.inputs.contains(update.cell_id) {
			Err(NotInputCell)
		} else if previous == update.value {
			Ok({ reactor, log: update.log })
		} else {
			values = reactor.computations.fold_try(
				reactor.values.insert(update.cell_id, update.value),
				|acc, cell| {
					if cell.inputs.any(|input_id| reactor.values.get(input_id) != acc.get(input_id)) {
						inputs = cell.inputs.map_try(|input_id| acc.get(input_id)) ? |KeyNotFound| UnknownCell
						computed = (cell.compute)(inputs) ? |message| ComputeFailed({ cell_id: cell.cell_id, message })
						Ok(acc.insert(cell.cell_id, computed))
					} else {
						Ok(acc)
					}
				},
			)?
			updated = { ..reactor, values }
			updated_log = reactor.callbacks.fold_try(
				update.log,
				|acc, registration| {
					before = reactor.value(registration.cell_id)?
					after = updated.value(registration.cell_id)?
					if before == after {
						Ok(acc)
					} else {
						Ok((registration.callback)(after, acc))
					}
				},
			)?
			Ok({ reactor: updated, log: updated_log })
		}
	}

	add_callback : React, { cell_id : Str, callback_id : Str, callback : CellValue, CallbackLog -> CallbackLog } -> Try(React, [UnknownCell, NotComputeCell, DuplicateCallback, ..])
	add_callback = |reactor, registration| {
		_ = reactor.value(registration.cell_id)?
		if reactor.inputs.contains(registration.cell_id) {
			Err(NotComputeCell)
		} else if reactor.callbacks.any(|existing| existing.cell_id == registration.cell_id and existing.callback_id == registration.callback_id) {
			Err(DuplicateCallback)
		} else {
			Ok({ ..reactor, callbacks: reactor.callbacks.append(registration) })
		}
	}

	remove_callback : React, { cell_id : Str, callback_id : Str } -> Try(React, [UnknownCell, NotComputeCell, ..])
	remove_callback = |reactor, registration| {
		_ = reactor.value(registration.cell_id)?
		if reactor.inputs.contains(registration.cell_id) {
			Err(NotComputeCell)
		} else {
			callbacks = reactor.callbacks.drop_if(|existing| existing.cell_id == registration.cell_id and existing.callback_id == registration.callback_id)
			Ok({ ..reactor, callbacks })
		}
	}
}
