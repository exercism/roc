import isodate.Date

Meetup :: {}.{
	Week : [First, Second, Third, Fourth, Last, Teenth]
	DayOfWeek : [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]

	meetup : { year : I64, month : U8, week : Week, day_of_week : DayOfWeek } -> Try(Str, [InvalidMonth, InvalidYear, ..])
	meetup = |{ year, month, week, day_of_week }|
		if month == 0 or month > 12 {
			Err(InvalidMonth)
		} else {
			first_day = Date.from_ymd(year, month, 1)
			first_weekday = first_day.weekday()
			first_time = (7 + day_of_week_number(day_of_week) - first_weekday) % 7 + 1
			day_of_month = {
				match week {
					First => first_time
					Second => first_time + 7
					Third => first_time + 14
					Fourth => first_time + 21
					Last => {
						if first_time + 28 > Date.days_in_month(year, month)
							first_time + 21
						else
							first_time + 28
					}
					Teenth => {
						if first_time == 6 {
							13
						} else {
							first_time + 14
						}
					}
				}
			}
			Ok("${year->pad_number(4)}-${month->pad_number(2)}-${day_of_month->pad_number(2)}")
		}
}

pad_number : _, U64 -> Str
pad_number = |number, pad| {
	number_str = number.to_str()
	num_zeros = pad.minus_saturated(number_str->Str.to_utf8()->List.len())
	zeros_str = "0".repeat(num_zeros)
	"${zeros_str}${number_str}"
}

day_of_week_number : DayOfWeek -> U8
day_of_week_number = |day_of_week| {
	match day_of_week {
		Sunday => 0
		Monday => 1
		Tuesday => 2
		Wednesday => 3
		Thursday => 4
		Friday => 5
		Saturday => 6
	}
}
