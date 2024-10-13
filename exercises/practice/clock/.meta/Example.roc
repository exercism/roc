module [create, toStr, add, subtract]

Clock : { hour : U8, minute : U8 }

minutesPerDay = 24 * 60

create : { hours ? I64, minutes ? I64 }* -> Clock
create = \{ hours ? 0, minutes ? 0 } ->
    hours24 = (hours % 24 + minutes // 60) % 24
    minutes60 = minutes % 60
    totalMinutes = ((hours24 * 60 + minutes60) % minutesPerDay + minutesPerDay) % minutesPerDay
    hh = totalMinutes // 60 |> Num.toU8
    mm = totalMinutes % 60 |> Num.toU8
    { hour: hh, minute: mm }

toStr : Clock -> Str
toStr = \{ hour, minute } ->
    zeroPadded = \num -> "$(if num < 10 then "0" else "")$(num |> Num.toStr)"
    "$(zeroPadded hour):$(zeroPadded minute)"

add : Clock, { hours ? I64, minutes ? I64 }* -> Clock
add = \{ hour, minute }, { hours ? 0, minutes ? 0 } ->
    totalHours = Num.toI64 hour + (hours % 24 + minutes // 60)
    totalMinutes = Num.toI64 minute + minutes % 60
    create { hours: totalHours, minutes: totalMinutes }

subtract : Clock, { hours ? I64, minutes ? I64 }* -> Clock
subtract = \clock, { hours ? 0, minutes ? 0 } ->
    clock |> add { hours: -(hours % 24 + minutes // 60), minutes: -(minutes % 60) }
