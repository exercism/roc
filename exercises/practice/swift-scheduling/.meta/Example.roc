##
## Example solution
##

import isodate.Date
import isodate.DateTime

SwiftScheduling :: {}.{
	Delivery : [Now, Asap, Eow, Month(U8), Quarter(U8)]

	delivery_date : { meeting_start : Str, delivery : Delivery } -> Try(Str, [InvalidMeetingStart, InvalidMonth, InvalidQuarter, ..])
	delivery_date = |{ meeting_start, delivery }| {
		start = DateTime.from_iso_str(meeting_start) ? |InvalidDateTimeFormat| InvalidMeetingStart
		year = I64.from_str(start.format("{YYYY}")) ? |BadNumStr| InvalidMeetingStart
		month = U8.from_str(start.format("{MM}")) ? |BadNumStr| InvalidMeetingStart
		hour = U8.from_str(start.format("{hh}")) ? |BadNumStr| InvalidMeetingStart

		result = match delivery {
			Now => start.add_hours(2).to_iso_str()
			Asap => if hour < 13 {
				start.format("{YYYY}-{MM}-{DD}T17:00:00")
			} else {
				start.add_days(1).format("{YYYY}-{MM}-{DD}T13:00:00")
			}
			Eow => {
				weekday = start.weekday().to_i64()
				if weekday >= 1 and weekday <= 3 {
					start.add_days(5 - weekday).format("{YYYY}-{MM}-{DD}T17:00:00")
				} else {
					start.add_days((7 - weekday) % 7).format("{YYYY}-{MM}-{DD}T20:00:00")
				}
			}
			Month(target) => {
				if target < 1 or target > 12 {
					return Err(InvalidMonth)
				}
				target_year = if month < target {
					year
				} else {
					year + 1
				}
				Date.from_ymd(target_year, target, 1)
					|> first_workday
					|> Date.format("{YYYY}-{MM}-{DD}T08:00:00")
			}
			Quarter(target) => {
				if target < 1 or target > 4 {
					return Err(InvalidQuarter)
				}
				last_month = target * 3
				target_year = if month <= last_month {
					year
				} else {
					year + 1
				}
				last_day = Date.days_in_month(target_year, last_month)
				Date.from_ymd(target_year, last_month, last_day)
					|> last_workday
					|> Date.format("{YYYY}-{MM}-{DD}T08:00:00")
			}
		}
		Ok(result)
	}
}

first_workday : Date -> Date
first_workday = |date| match date.weekday() {
	6 => date.add_days(2)
	0 => date.add_days(1)
	_ => date
}

last_workday : Date -> Date
last_workday = |date| match date.weekday() {
	6 => date.add_days(-1)
	0 => date.add_days(-2)
	_ => date
}
