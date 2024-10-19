module [meetup]

import isodate.Date

Week : [First, Second, Third, Fourth, Last, Teenth]
DayOfWeek : [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]

meetup : { year : I64, month : U8, week : Week, dayOfWeek : DayOfWeek } -> Result Str [InvalidMonth, InvalidYear]
meetup = \{ year, month, week, dayOfWeek } ->
    if month == 0 || month > 12 then
        Err InvalidMonth
        else

    firstDay = Date.fromYmd year month 1
    firstWeekday = Date.weekday firstDay.year firstDay.month firstDay.dayOfMonth
    firstTime = (7 + dayOfWeekNumber dayOfWeek - firstWeekday) % 7 + 1
    dayOfMonth =
        when week is
            First -> firstTime
            Second -> firstTime + 7
            Third -> firstTime + 14
            Fourth -> firstTime + 21
            Last ->
                if firstTime + 28 > Date.daysInMonth year month then
                    firstTime + 21
                else
                    firstTime + 28

            Teenth ->
                if firstTime == 6 then 13 else firstTime + 14
    Ok "$(year |> padNumber 4)-$(month |> padNumber 2)-$(dayOfMonth |> padNumber 2)"

padNumber : Num *, U64 -> Str
padNumber = \number, pad ->
    numberStr = number |> Num.toStr
    numZeros = pad |> Num.subSaturated (numberStr |> Str.toUtf8 |> List.len)
    "$(Str.repeat "0" numZeros)$(numberStr)"

dayOfWeekNumber : DayOfWeek -> U8
dayOfWeekNumber = \dayOfWeek ->
    when dayOfWeek is
        Sunday -> 0
        Monday -> 1
        Tuesday -> 2
        Wednesday -> 3
        Thursday -> 4
        Friday -> 5
        Saturday -> 6
