Clock :: { hour : U8, minute : U8 }.{
	create : { hour : I64, minute : I64 } -> Clock
	create = |{ hour, minute }| {
		crash "Please implement the 'create' function"
	}

	to_str : Clock -> Str
	to_str = |clock| {
		crash "Please implement the 'to_str' function"
	}

	add : Clock, { hour : I64, minute : I64 } -> Clock
	add = |clock, { hour, minute }| {
		crash "Please implement the 'add' function"
	}

	subtract : Clock, { hour : I64, minute : I64 } -> Clock
	subtract = |clock, { hour, minute }| {
		crash "Please implement the 'subtract' function"
	}
}
