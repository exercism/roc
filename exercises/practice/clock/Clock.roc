module [create, toStr, add, subtract]

Clock : { hour : U8, minute : U8 }

create : { hours ? I64, minutes ? I64 }* -> Clock
create = \{ hours ? 0, minutes ? 0 } ->
    crash "Please implement the 'create' function"

toStr : Clock -> Str
toStr = \{ hour, minute } ->
    crash "Please implement the 'toStr' function"

add : Clock, { hours ? I64, minutes ? I64 }* -> Clock
add = \{ hour, minute }, { hours ? 0, minutes ? 0 } ->
    crash "Please implement the 'add' function"

subtract : Clock, { hours ? I64, minutes ? I64 }* -> Clock
subtract = \clock, { hours ? 0, minutes ? 0 } ->
    crash "Please implement the 'subtract' function"

