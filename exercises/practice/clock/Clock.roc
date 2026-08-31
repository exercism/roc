Clock :: { hour : U8, minute : U8 }.{
	OptionalHourMinute := { hour : I64 ?? 0, minute : I64 ?? 0 }

	create : OptionalHourMinute -> Clock
	create = |{ hour, minute }| {
		crash "Please implement the 'create' function"
	}

	to_str : Clock -> Str
	to_str = |clock| {
		crash "Please implement the 'to_str' function"
	}

	add : Clock, OptionalHourMinute -> Clock
	add = |clock, { hour, minute }| {
		crash "Please implement the 'add' function"
	}

	subtract : Clock, OptionalHourMinute -> Clock
	subtract = |clock, { hour, minute }| {
		crash "Please implement the 'subtract' function"
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _
}
