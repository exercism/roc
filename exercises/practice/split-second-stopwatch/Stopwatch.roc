Stopwatch :: {
	# TODO: change this opaque type however you need
	todo1 : U64,
	todo2 : U64,
	todo3 : U64,
	# etc.
}.{
	State : [Ready, Running, Stopped]

	Time := { hour : U64, minute : U8, second : U8 }.{
		# The following line enables the default `is_eq` implementation
		is_eq : _

		## This function parses a Str formatted as "HH:MM:SS" to a Time
		from_quote : Str -> Try(Time, [BadQuotedBytes(Str)])
		from_quote = |time_str| {
			crash "Please implement the 'from_quote' function"
		}
	}

	create : () -> Stopwatch
	create = || {
		crash "Please implement the 'create' function"
	}

	start : Stopwatch -> Try(Stopwatch, _)
	start = |stopwatch| {
		crash "Please implement the 'start' function"
	}

	stop : Stopwatch -> Try(Stopwatch, _)
	stop = |stopwatch| {
		crash "Please implement the 'stop' function"
	}

	lap : Stopwatch -> Try(Stopwatch, _)
	lap = |stopwatch| {
		crash "Please implement the 'lap' function"
	}

	reset : Stopwatch -> Try(Stopwatch, _)
	reset = |stopwatch| {
		crash "Please implement the 'reset' function"
	}

	advance_time : Stopwatch, Time -> Stopwatch
	advance_time = |stopwatch, time| {
		crash "Please implement the 'advance_time' function"
	}

	state : Stopwatch -> State
	state = |stopwatch| {
		crash "Please implement the 'state' function"
	}

	current_lap : Stopwatch -> Time
	current_lap = |stopwatch| {
		crash "Please implement the 'current_lap' function"
	}

	previous_laps : Stopwatch -> List(Time)
	previous_laps = |stopwatch| {
		crash "Please implement the 'previous_laps' function"
	}

	total : Stopwatch -> Time
	total = |stopwatch| {
		crash "Please implement the 'total' function"
	}
}
