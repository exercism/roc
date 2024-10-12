module [meetup]

import isodate.Date
import isodate.Const

Week : [First, Second, Third, Fourth, Last, Teenth]
DayOfWeek : [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]

meetup : { year : I64, month : U8, week : Week, dayOfWeek : DayOfWeek } -> Result Str [InvalidMonth, InvalidYear]
meetup = \{ year, month, week, dayOfWeek } ->
    if month == 0 || month > 12 then
        Err InvalidMonth
        else

    firstDay = Date.fromYmd year month 1
    firstWeekday = weekday firstDay.year firstDay.month firstDay.dayOfMonth
    firstTime = (7 + dayOfWeekNumber dayOfWeek - firstWeekday) % 7 + 1
    dayOfMonth =
        when week is
            First -> firstTime
            Second -> firstTime + 7
            Third -> firstTime + 14
            Fourth -> firstTime + 21
            Last ->
                if firstTime + 28 > daysInMonth year month then
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

isLeapYear : I64 -> Bool
isLeapYear = \year ->
    (year % 4 == 0) && (year % 400 == 0 || year % 100 != 0)

daysInMonth : I64, U8 -> U8
daysInMonth = \year, month ->
    maybeDays =
        [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        |> List.get (month - 1 |> Num.toU64)
    when maybeDays is
        Ok days -> if isLeapYear year && month == 2 then 29 else days
        Err OutOfBounds -> crash "Impossible, we checked the month before"

weekday : I64, U8, U8 -> U8
weekday = \year, month, day ->
    year2xxx = (year % 400) + 2400 # to handle years before the epoch
    date = Date.fromYmd year2xxx month day
    daysSinceEpoch = Date.toNanosSinceEpoch date // Const.nanosPerDay
    (daysSinceEpoch + 4) % 7 |> Num.toU8
