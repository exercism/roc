module [meetup]

import isodate.Date

Week : [First, Second, Third, Fourth, Last, Teenth]
DayOfWeek : [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]

meetup : { year : I64, month : U8, week : Week, day_of_week : DayOfWeek } -> Result Str [InvalidMonth, InvalidYear]
meetup = |{ year, month, week, day_of_week }|
    if month == 0 or month > 12 then
        Err(InvalidMonth)
    else
        first_day = Date.from_ymd(year, month, 1)
        first_weekday = Date.weekday(first_day.year, first_day.month, first_day.day_of_month)
        first_time = (7 + day_of_week_number(day_of_week) - first_weekday) % 7 + 1
        day_of_month =
            when week is
                First -> first_time
                Second -> first_time + 7
                Third -> first_time + 14
                Fourth -> first_time + 21
                Last ->
                    if first_time + 28 > Date.days_in_month(year, month) then
                        first_time + 21
                    else
                        first_time + 28

                Teenth ->
                    if first_time == 6 then 13 else first_time + 14
        Ok("${year |> pad_number(4)}-${month |> pad_number(2)}-${day_of_month |> pad_number(2)}")

pad_number : Num *, U64 -> Str
pad_number = |number, pad|
    number_str = number |> Num.to_str
    num_zeros = pad |> Num.sub_saturated((number_str |> Str.to_utf8 |> List.len))
    "${Str.repeat("0", num_zeros)}${number_str}"

day_of_week_number : DayOfWeek -> U8
day_of_week_number = |day_of_week|
    when day_of_week is
        Sunday -> 0
        Monday -> 1
        Tuesday -> 2
        Wednesday -> 3
        Thursday -> 4
        Friday -> 5
        Saturday -> 6
