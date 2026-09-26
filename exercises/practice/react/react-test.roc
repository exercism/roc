# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/react/canonical-data.json
# File last updated on 2026-09-26

import React

## input cells have a value
expect {
	result = React.create()
		.add_input({ cell_id: "input", value: 10 })?
		|> expect_value({ cell_id: "input", value: 10 })

	result.is_ok()
}

## an input cell's value can be set
expect {
	result = React.create()
		.add_input({ cell_id: "input", value: 4 })?
		.set_value({ cell_id: "input", value: 20, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.empty(),
			not_called: [],
		})?
		|> expect_value({ cell_id: "input", value: 20 })

	result.is_ok()
}

## compute cells calculate initial value
expect {
	result = React.create()
		.add_input({ cell_id: "input", value: 1 })?
		.add_compute({
			cell_id: "output",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a + 1)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		|> expect_value({ cell_id: "output", value: 2 })

	result.is_ok()
}

## compute cells take inputs in the right order
expect {
	result = React.create()
		.add_input({ cell_id: "one", value: 1 })?
		.add_input({ cell_id: "two", value: 2 })?
		.add_compute({
			cell_id: "output",
			inputs: ["one", "two"],
			compute: |values| match values {
				[a, b] => Ok(a + b * 10)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		|> expect_value({ cell_id: "output", value: 21 })

	result.is_ok()
}

## compute cells update value when dependencies are changed
expect {
	result = React.create()
		.add_input({ cell_id: "input", value: 1 })?
		.add_compute({
			cell_id: "output",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a + 1)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.set_value({ cell_id: "input", value: 3, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.empty(),
			not_called: [],
		})?
		|> expect_value({ cell_id: "output", value: 4 })

	result.is_ok()
}

## compute cells can depend on other compute cells
expect {
	result = React.create()
		.add_input({ cell_id: "input", value: 1 })?
		.add_compute({
			cell_id: "times_two",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a * 2)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_compute({
			cell_id: "times_thirty",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a * 30)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_compute({
			cell_id: "output",
			inputs: ["times_two", "times_thirty"],
			compute: |values| match values {
				[a, b] => Ok(a + b)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		|> expect_value({ cell_id: "output", value: 32 })?
		.set_value({ cell_id: "input", value: 3, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.empty(),
			not_called: [],
		})?
		|> expect_value({ cell_id: "output", value: 96 })

	result.is_ok()
}

## compute cells fire callbacks
expect {
	result = React.create()
		.add_input({ cell_id: "input", value: 1 })?
		.add_compute({
			cell_id: "output",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a + 1)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_callback({ cell_id: "output", callback_id: "callback1", callback: record_callback("callback1") })?
		.set_value({ cell_id: "input", value: 3, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.single("callback1", 4),
			not_called: [],
		})

	result.is_ok()
}

## callback cells only fire on change
expect {
	result = React.create()
		.add_input({ cell_id: "input", value: 1 })?
		.add_compute({
			cell_id: "output",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(
					if a < 3 {
						111
					} else {
						222
					},
				)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_callback({ cell_id: "output", callback_id: "callback1", callback: record_callback("callback1") })?
		.set_value({ cell_id: "input", value: 2, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.empty(),
			not_called: ["callback1"],
		})?
		.set_value({ cell_id: "input", value: 4, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.single("callback1", 222),
			not_called: [],
		})

	result.is_ok()
}

## callbacks do not report already reported values
expect {
	result = React.create()
		.add_input({ cell_id: "input", value: 1 })?
		.add_compute({
			cell_id: "output",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a + 1)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_callback({ cell_id: "output", callback_id: "callback1", callback: record_callback("callback1") })?
		.set_value({ cell_id: "input", value: 2, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.single("callback1", 3),
			not_called: [],
		})?
		.set_value({ cell_id: "input", value: 3, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.single("callback1", 4),
			not_called: [],
		})

	result.is_ok()
}

## callbacks can fire from multiple cells
expect {
	result = React.create()
		.add_input({ cell_id: "input", value: 1 })?
		.add_compute({
			cell_id: "plus_one",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a + 1)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_compute({
			cell_id: "minus_one",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a - 1)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_callback({ cell_id: "plus_one", callback_id: "callback1", callback: record_callback("callback1") })?
		.add_callback({ cell_id: "minus_one", callback_id: "callback2", callback: record_callback("callback2") })?
		.set_value({ cell_id: "input", value: 10, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.from_list([
				("callback1", 11),
				("callback2", 9),
			]),
			not_called: [],
		})

	result.is_ok()
}

## callbacks can be added and removed
expect {
	result = React.create()
		.add_input({ cell_id: "input", value: 11 })?
		.add_compute({
			cell_id: "output",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a + 1)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_callback({ cell_id: "output", callback_id: "callback1", callback: record_callback("callback1") })?
		.add_callback({ cell_id: "output", callback_id: "callback2", callback: record_callback("callback2") })?
		.set_value({ cell_id: "input", value: 31, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.from_list([
				("callback1", 32),
				("callback2", 32),
			]),
			not_called: [],
		})?
		.remove_callback({ cell_id: "output", callback_id: "callback1" })?
		.add_callback({ cell_id: "output", callback_id: "callback3", callback: record_callback("callback3") })?
		.set_value({ cell_id: "input", value: 41, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.from_list([
				("callback2", 42),
				("callback3", 42),
			]),
			not_called: ["callback1"],
		})

	result.is_ok()
}

## removing a callback multiple times doesn't interfere with other callbacks
expect {
	result = React.create()
		.add_input({ cell_id: "input", value: 1 })?
		.add_compute({
			cell_id: "output",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a + 1)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_callback({ cell_id: "output", callback_id: "callback1", callback: record_callback("callback1") })?
		.add_callback({ cell_id: "output", callback_id: "callback2", callback: record_callback("callback2") })?
		.remove_callback({ cell_id: "output", callback_id: "callback1" })?
		.remove_callback({ cell_id: "output", callback_id: "callback1" })?
		.remove_callback({ cell_id: "output", callback_id: "callback1" })?
		.set_value({ cell_id: "input", value: 2, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.single("callback2", 3),
			not_called: ["callback1"],
		})

	result.is_ok()
}

## callbacks should only be called once even if multiple dependencies change
expect {
	result = React.create()
		.add_input({ cell_id: "input", value: 1 })?
		.add_compute({
			cell_id: "plus_one",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a + 1)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_compute({
			cell_id: "minus_one1",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a - 1)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_compute({
			cell_id: "minus_one2",
			inputs: ["minus_one1"],
			compute: |values| match values {
				[a] => Ok(a - 1)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_compute({
			cell_id: "output",
			inputs: ["plus_one", "minus_one2"],
			compute: |values| match values {
				[a, b] => Ok(a * b)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_callback({ cell_id: "output", callback_id: "callback1", callback: record_callback("callback1") })?
		.set_value({ cell_id: "input", value: 4, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.single("callback1", 10),
			not_called: [],
		})

	result.is_ok()
}

## callbacks should not be called if dependencies change but output value doesn't change
expect {
	result = React.create()
		.add_input({ cell_id: "input", value: 1 })?
		.add_compute({
			cell_id: "plus_one",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a + 1)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_compute({
			cell_id: "minus_one",
			inputs: ["input"],
			compute: |values| match values {
				[a] => Ok(a - 1)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_compute({
			cell_id: "always_two",
			inputs: ["plus_one", "minus_one"],
			compute: |values| match values {
				[a, b] => Ok(a - b)
				_ => Err("Unexpected number of compute-cell inputs")
			},
		})?
		.add_callback({ cell_id: "always_two", callback_id: "callback1", callback: record_callback("callback1") })?
		.set_value({ cell_id: "input", value: 2, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.empty(),
			not_called: ["callback1"],
		})?
		.set_value({ cell_id: "input", value: 3, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.empty(),
			not_called: ["callback1"],
		})?
		.set_value({ cell_id: "input", value: 4, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.empty(),
			not_called: ["callback1"],
		})?
		.set_value({ cell_id: "input", value: 5, log: Dict.empty() })?
		|> expect_callbacks({
			called: Dict.empty(),
			not_called: ["callback1"],
		})

	result.is_ok()
}

## a failed initial computation returns an error
expect {
	result = React.create()
		.add_input({ cell_id: "numerator", value: 12 })?
		.add_input({ cell_id: "denominator", value: 0 })?
		.add_compute({ cell_id: "quotient", inputs: ["numerator", "denominator"], compute: divide })

	result.is_err()
}

## incorrect compute input counts return an error
expect {
	result = React.create()
		.add_compute({ cell_id: "quotient", inputs: [], compute: divide })

	result.is_err()
}

## a failed computation leaves the original reactor usable
expect {
	reactor = React.create()
		.add_input({ cell_id: "numerator", value: 12 })?
		.add_input({ cell_id: "denominator", value: 2 })?
		.add_compute({ cell_id: "quotient", inputs: ["numerator", "denominator"], compute: divide })?
		.add_callback({ cell_id: "quotient", callback_id: "division", callback: record_callback("division") })?
	result = reactor.set_value({ cell_id: "denominator", value: 0, log: Dict.empty() })
	expect result.is_err()
	expect reactor.value("denominator") == Ok(2)
	expect reactor.value("quotient") == Ok(6)

	updated = reactor.set_value({ cell_id: "denominator", value: 3, log: Dict.empty() })?
	updated.reactor.value("quotient") == Ok(4) and updated.log == Dict.single("division", [4])
}

divide : List(React.CellValue) -> Try(React.CellValue, Str)
divide = |values| match values {
	[_, 0] => Err("Division by zero")
	[numerator, denominator] => Ok(numerator // denominator)
	_ => Err("Expected two inputs")
}

record_callback : Str -> (I64, React.CallbackLog -> React.CallbackLog)
record_callback = |callback_id| |value, log| {
	previous = log.get(callback_id) ?? []
	log.insert(callback_id, previous.append(value))
}

expect_value : React, { cell_id : Str, value : I64 } -> Try(React, _)
expect_value = |reactor, { cell_id, value }| {
	actual = reactor.value(cell_id) ? |_error| MissingCell(cell_id)
	if actual == value {
		Ok(reactor)
	} else {
		Err(UnexpectedValue({ cell_id, expected: value, actual }))
	}
}

expect_callbacks : { reactor : React, log : React.CallbackLog }, { called : Dict(Str, I64), not_called : List(Str) } -> Try(React, _)
expect_callbacks = |{ reactor, log }, { called, not_called }| {
	expected = called.to_list().map(|(callback_id, value)| (callback_id, [value])) |> Dict.from_list
	silent = not_called.all(|callback_id| (log.get(callback_id) ?? []).is_empty())
	if log == expected and silent {
		Ok(reactor)
	} else {
		Err(UnexpectedCallbacks)
	}
}
