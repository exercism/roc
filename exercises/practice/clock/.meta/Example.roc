module [create, toStr, add, subtract]

Clock : { hour : U8, minute : U8 }

minutesPerDay = 24 * 60

create : { hours ? I64, minutes ? I64 }* -> Clock
create = \{ hours ? 0, minutes ? 0 } ->
    totalMinutes = ((hours * 60 + minutes) % minutesPerDay + minutesPerDay) % minutesPerDay
    hh = totalMinutes // 60 |> Num.toU8
    mm = totalMinutes % 60 |> Num.toU8
    { hour: hh, minute: mm }

toStr : Clock -> Str
toStr = \{ hour, minute } ->
    zeroPadded = \num -> "$(if num < 10 then "0" else "")$(num |> Num.toStr)"
    "$(zeroPadded hour):$(zeroPadded minute)"

add : Clock, { hours ? I64, minutes ? I64 }* -> Clock
add = \{ hour, minute }, { hours ? 0, minutes ? 0 } ->
    totalHours = Num.toI64 hour + hours
    totalMinutes = Num.toI64 minute + minutes
    create { hours: totalHours, minutes: totalMinutes }

subtract : Clock, { hours ? I64, minutes ? I64 }* -> Clock
subtract = \clock, { hours ? 0, minutes ? 0 } ->
    clock |> add { hours: -hours, minutes: -minutes }
