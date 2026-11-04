##
## Example solution
##

Stopwatch :: {
	previous_laps : List(Stopwatch.Time),
	current_lap : Stopwatch.Time,
	state : Stopwatch.State,
}.{
	State : [Ready, Running, Stopped]

	Time := { hour : U64, minute : U8, second : U8 }.{
		# The following line enables the default `is_eq` implementation
		is_eq : _

		## This function parses a Str formatted as "HH:MM:SS" to a Time
		from_quote : Str -> Try(Time, [BadQuotedBytes(Str)])
		from_quote = |time_str| {
			parts = time_str.split_on(":").map_try(U64.from_str) ? |BadNumStr| BadQuotedBytes(time_str)
			match parts {
				[hour, minute, second] => {
					if minute > 59 or second > 59 {
						Err(BadQuotedBytes(time_str))
					} else {
						Ok(
							Time.{
								hour,
								minute: minute.to_u8_try() ?? {
									crash "Unreachable"
								},
								second: second.to_u8_try() ?? {
									crash "Unreachable"
								},
							},
						)
					}
				}
				_ => Err(BadQuotedBytes(time_str))
			}
		}

		default : () -> Time
		default = || "00:00:00"

		plus : Time, Time -> Time
		plus = |t1, t2| {
			seconds = t1.second.to_u64() + t2.second.to_u64() + t1.minute.to_u64() * 60 + t2.minute.to_u64() * 60 + t1.hour * 3600 + t2.hour * 3600
			second = (seconds % 60).to_u8_try() ?? {
				crash "Unreachable"
			}
			minute = (seconds / 60 % 60).to_u8_try() ?? {
				crash "Unreachable"
			}
			hour = seconds / 3600
			{ hour, minute, second }
		}
	}

	create : () -> Stopwatch
	create = || {
		{ previous_laps: [], current_lap: Time.default(), state: Ready }
	}

	start : Stopwatch -> Try(Stopwatch, _)
	start = |Stopwatch.(stopwatch)| {
		match stopwatch.state {
			Ready | Stopped => Ok({ ..stopwatch, state: Running })
			Running => Err(InvalidState)
		}
	}

	stop : Stopwatch -> Try(Stopwatch, _)
	stop = |Stopwatch.(stopwatch)| {
		match stopwatch.state {
			Running => Ok({ ..stopwatch, state: Stopped })
			Ready | Stopped => Err(InvalidState)
		}
	}

	lap : Stopwatch -> Try(Stopwatch, _)
	lap = |Stopwatch.(stopwatch)| {
		match stopwatch.state {
			Running => {
				previous_laps = stopwatch.previous_laps.append(stopwatch.current_lap)
				Ok({ previous_laps, current_lap: Stopwatch.Time.default(), state: Running })
			}
			Ready | Stopped => Err(InvalidState)
		}
	}

	reset : Stopwatch -> Try(Stopwatch, _)
	reset = |Stopwatch.(stopwatch)| {
		match stopwatch.state {
			Stopped => Ok(create())
			Ready | Running => Err(InvalidState)
		}
	}

	advance_time : Stopwatch, Time -> Stopwatch
	advance_time = |Stopwatch.(stopwatch), time| {
		match stopwatch.state {
			Running => { ..stopwatch, current_lap: stopwatch.current_lap + time }
			Ready | Stopped => stopwatch
		}
	}

	state : Stopwatch -> State
	state = |Stopwatch.(stopwatch)| {
		stopwatch.state
	}

	current_lap : Stopwatch -> Time
	current_lap = |Stopwatch.(stopwatch)| {
		stopwatch.current_lap
	}

	previous_laps : Stopwatch -> List(Time)
	previous_laps = |Stopwatch.(stopwatch)| {
		stopwatch.previous_laps
	}

	total : Stopwatch -> Time
	total = |Stopwatch.(stopwatch)| {
		stopwatch.previous_laps.sum() + stopwatch.current_lap
	}
}

expect Stopwatch.Time.default() == "00:00:00"
expect Stopwatch.Time.({ hour: 123, minute: 4, second: 10 }) == "123:04:10"
expect {
	t1 : Stopwatch.Time
	t1 = "99:59:59"

	t1 + "02:02:02" == "102:02:01"
}

expect {
	stopwatch = Stopwatch.create()
		.start()?
		.advance_time("00:00:10")
		.advance_time("00:00:25")
	stopwatch.current_lap() == "00:00:35"
}
