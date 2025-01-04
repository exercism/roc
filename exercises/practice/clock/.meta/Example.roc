module [create, to_str, add, subtract]

Clock : { hour : U8, minute : U8 }

minutes_per_day = 24 * 60

create : { hours ? I64, minutes ? I64 }* -> Clock
create = \{ hours ? 0, minutes ? 0 } ->
    hours24 = (hours % 24 + minutes // 60) % 24
    minutes60 = minutes % 60
    total_minutes = ((hours24 * 60 + minutes60) % minutes_per_day + minutes_per_day) % minutes_per_day
    hh = total_minutes // 60 |> Num.toU8
    mm = total_minutes % 60 |> Num.toU8
    { hour: hh, minute: mm }

to_str : Clock -> Str
to_str = \{ hour, minute } ->
    zero_padded = \num -> "$(if num < 10 then "0" else "")$(num |> Num.toStr)"
    "$(zero_padded hour):$(zero_padded minute)"

add : Clock, { hours ? I64, minutes ? I64 }* -> Clock
add = \{ hour, minute }, { hours ? 0, minutes ? 0 } ->
    total_hours = Num.toI64 hour + (hours % 24 + minutes // 60)
    total_minutes = Num.toI64 minute + minutes % 60
    create { hours: total_hours, minutes: total_minutes }

subtract : Clock, { hours ? I64, minutes ? I64 }* -> Clock
subtract = \clock, { hours ? 0, minutes ? 0 } ->
    clock |> add { hours: -(hours % 24 + minutes // 60), minutes: -(minutes % 60) }