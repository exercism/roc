## Roc API

Use an immutable `React` value. Each operation returns an updated reactor; keep that value for subsequent operations. Cells are identified by `cell_id`; callbacks by `callback_id`. Both identifiers are strings supplied when they are registered. Callback registration and removal take both identifiers to specify the cell and its callback.

A compute function receives a list of cell values in the same order as its `inputs` list of cell identifiers. It returns `Ok(value)` on success or `Err(message)` with a string describing a failure, such as an incorrect input count or division by zero. Its dependencies must already exist when the compute cell is added. Both `add_compute` and `set_value` report computation errors as `ComputeFailed({ cell_id, message })`. If a computation fails during an update, no updated reactor is returned and no callbacks run; the original reactor remains usable.

Callbacks are pure functions of type `React.CellValue, React.CallbackLog -> React.CallbackLog`. Each callback receives the cell's new value and the current log, then returns an updated log. `set_value` takes a record containing `cell_id`, `value`, and the initial `log`, and returns both the updated reactor and the final log. Pass each callback's returned log to the next callback; callback order is unspecified.

`React.CallbackLog` is an alias for `Dict(Str, List(I64))`: it records the values received by each callback identifier. The tests pass an empty log to each input update to check that callbacks ran exactly once or did not run at all.

Registering a callback does not call it. Removing the same callback more than once is allowed and must not affect other callbacks. All callbacks for an update must observe the final, stable cell values.
