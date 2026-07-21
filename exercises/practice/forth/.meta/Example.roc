Forth :: {}.{
	Stack : List(I16)

	evaluate : Str -> Try(Stack, Str)
	evaluate = |program| {
		lower = to_lower(program)
		match parse(lower) {
			Ok(operations) => {
				match interpret(operations) {
					Ok(stack) => Ok(stack)
					Err(err) => Err(handle_error(err))
				}
			}
			Err(err) => Err(handle_error(err))
		}
	}
}

Defs : Dict(Str, List(Str))

Op : [
	Dup,
	Drop,
	Swap,
	Over,
	Add,
	Subtract,
	Multiply,
	Divide,
	Number(I16),
]

interpret : List(Op) -> Try(Stack, _)
interpret = |program| {
	help = |ops, stack| {
		match ops {
			[] => Ok(stack)
			[op, .. as rest] => {
				match step(stack, op) {
					Ok(new_stack) => help(rest, new_stack)
					Err(error) => Err(EvaluationError({ error, stack, op, ops }))
				}
			}
		}
	}
	help(program, [])
}

step : Stack, Op -> Try(Stack, _)
step = |stack, op| {
	match op {
		Number(x) => Ok(stack.append(x))
		Dup => {
			match stack {
				[.., x] => Ok(stack.append(x))
				_ => Err(Arity(1))
			}
		}

		Drop => {
			match stack {
				[.. as rest, _] => Ok(rest)
				_ => Err(Arity(1))
			}
		}

		Swap => {
			match stack {
				[.. as rest, x, y] => Ok(rest.append(y).append(x))
				_ => Err(Arity(2))
			}
		}

		Over => {
			match stack {
				[.. as rest, x, y] => Ok(rest.concat([x, y, x]))
				_ => Err(Arity(2))
			}
		}

		Add => {
			match stack {
				[.. as rest, x, y] => Ok(rest.append(x + y))
				_ => Err(Arity(2))
			}
		}

		Subtract => {
			match stack {
				[.. as rest, x, y] => Ok(rest.append(x - y))
				_ => Err(Arity(2))
			}
		}

		Multiply => {
			match stack {
				[.. as rest, x, y] => Ok(rest.append(x * y))
				_ => Err(Arity(2))
			}
		}

		Divide => {
			match stack {
				[.. as rest, x, y] => {
					if y == 0 {
						Err(DivByZero)
					} else {
						Ok(rest.append(x // y))
					}
				}
				_ => Err(Arity(2))
			}
		}
	}
}

parse : Str -> Try(List(Op), _)
parse = |str| {
	match Str.split_on(Str.trim(str), "\n") {
		[.. as def_lines, program] => {
			defs = parse_defs(def_lines)?
			program.split_on(" ")
				->flatten_defs(defs)
				->map_try(to_op)
		}
		[] => Ok([])
	}
}

parse_defs : List(Str) -> Try(Defs, _)
parse_defs = |lines| {
	List.fold_until(
		lines,
		Ok(Dict.empty()),
		|acc_res, line| {
			match acc_res {
				Ok(defs) => {
					match line.split_on(" ") {
						[":", name, .. as tokens, ";"] => {
							match parse_def(tokens, defs) {
								Ok(ops) => Continue(Ok(defs.insert(name, ops)))
								Err(err) => Break(Err(err))
							}
						}
						_ => Break(Err(UnableToParseDef(line)))
					}
				}
				Err(err) => Break(Err(err))
			}
		},
	)
}

parse_def : List(Str), Defs -> Try(List(Str), _)
parse_def = |tokens, defs| {
	List.fold_until(
		tokens,
		Ok([]),
		|acc_res, token| {
			match acc_res {
				Ok(ops) => {
					match defs.get(token) {
						Ok(body) => Continue(Ok(ops.concat(body)))
						Err(KeyNotFound) => {
							if is_builtin(token) {
								Continue(Ok(ops.append(token)))
							} else {
								Break(Err(UnknownName(token)))
							}
						}
					}
				}
				Err(err) => Break(Err(err))
			}
		},
	)
}

is_builtin : Str -> Bool
is_builtin = |token| {
	builtins = ["dup", "drop", "swap", "over", "+", "-", "*", "/"]
	builtins.contains(token) or (
		match I16.from_str(token) {
			Ok(_) => Bool.True
			Err(_) => Bool.False
		},
	)
}

flatten_defs : List(Str), Defs -> List(Str)
flatten_defs = |tokens, defs| {
	tokens->join_map(
		|token| {
			match defs.get(token) {
				Ok(body) => body
				_ => [token]
			}
		},
	)
}

to_op : Str -> Try(Op, _)
to_op = |str| {
	match str {
		"dup" => Ok(Dup)
		"drop" => Ok(Drop)
		"swap" => Ok(Swap)
		"over" => Ok(Over)
		"+" => Ok(Add)
		"-" => Ok(Subtract)
		"*" => Ok(Multiply)
		"/" => Ok(Divide)
		_ => {
			match I16.from_str(str) {
				Ok(num) => Ok(Number(num))
				Err(_) => Err(UnknownName(str))
			}
		}
	}
}

handle_error : _ -> Str
handle_error = |err| {
	match err {
		UnknownName(key) => "Hmm, I don't know any operations called '${key}'. Maybe there's a typo?"
		UnableToParseDef(line) => "This is supposed to be a definition, but I'm not sure how to parse it:\n${line}"
		EvaluationError({ error, stack, op, ops }) => {
			match error {
				Arity(1) => "Oops! '${op_to_str(op)}' expected 1 argument, but the stack was empty.\n${show_execution(stack, ops)}"
				Arity(n) => "Oops! '${op_to_str(op)}' expected ${n.to_str()} arguments, but there weren't enough on the stack.\n${show_execution(stack, ops)}"
				DivByZero => "Sorry, division by zero is not allowed.\n${show_execution(stack, ops)}"
			}
		}
	}
}

show_execution : Stack, List(Op) -> Str
show_execution = |stack, ops| {
	stack_str = 
		stack.map(|n| n.to_str())
			->Str.join_with(" ")
	ops_str = 
		ops.map(op_to_str)
			->Str.join_with(" ")
	"${stack_str} | ${ops_str}"
}

op_to_str : Op -> Str
op_to_str = |op| {
	match op {
		Dup => "dup"
		Drop => "drop"
		Swap => "swap"
		Over => "over"
		Add => "+"
		Subtract => "-"
		Multiply => "*"
		Divide => "/"
		Number(num) => num.to_str()
	}
}

to_lower : Str -> Str
to_lower = |str| {
	result = 
		str.to_utf8()
			.map(
				|byte| {
					if 'A' <= byte and byte <= 'Z' {
						byte - 'A' + 'a'
					} else {
						byte
					}
				},
			)
			->Str.from_utf8()
	match result {
		Ok(s) => s
		_ => {
			crash "There was an unexpected error converting back to Str"
		}
	}
}

# The following function should soon be available in Roc's builtins
join_map : i, (a -> j) -> List(b) where [i.iter : i -> Iter(a), j.iter : j -> Iter(b)]
join_map = |list, func| {
	var $state = []
	for item in list {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}

map_try : i, (a -> Try(b, err)) -> Try(List(b), err) where [i.iter : i -> Iter(a)]
map_try = |list, func| {
	var $state = []
	for item in list {
		$state = $state.append(func(item)?)
	}
	Ok($state)
}