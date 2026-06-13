Clock :: { hour : U8, minute : U8 }.{
	create : { hour : I64, minute : I64 } -> Clock
	create = |{ hour, minute }| {
		hour24 = (hour % 24 + minute // 60) % 24
		minute60 = minute % 60
		minutes_per_day = 24 * 60
		total_minute = ((hour24 * 60 + minute60) % minutes_per_day + minutes_per_day) % minutes_per_day
		hh = (total_minute // 60).to_u8_try() ?? {
			crash "Unreachable"
		}
		mm = (total_minute % 60).to_u8_try() ?? {
			crash "Unreachable"
		}
		{ hour: hh, minute: mm }
	}

	to_str : Clock -> Str
	to_str = |{ hour, minute }| {
		zero_padded = |num| "${if num < 10 "0" else ""}${num.to_str()}"
		"${zero_padded(hour)}:${zero_padded(minute)}"
	}

	add : Clock, { hour : I64, minute : I64 } -> Clock
	add = |clock, { hour, minute }| {
		total_hour = clock.hour.to_i64() + (hour % 24 + minute // 60)
		total_minute = clock.minute.to_i64() + minute % 60
		create({ hour: total_hour, minute: total_minute })
	}

	subtract : Clock, { hour : I64, minute : I64 } -> Clock
	subtract = |clock, { hour, minute }| {
		clock.add({ hour: -(hour % 24 + minute // 60), minute: -(minute % 60) })
	}
}
