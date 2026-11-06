Meetup :: {}.{
	Week : [First, Second, Third, Fourth, Last, Teenth]
	DayOfWeek : [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]

	meetup : { year : I64, month : U8, week : Week, day_of_week : DayOfWeek } -> Try(Str, _)
	meetup = |{ year, month, week, day_of_week }| {
		crash "Please implement the 'meetup' function"
	}
}
