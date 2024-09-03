module [convert]

convert : U64 -> Str
convert = \number ->
    pling = if number % 3 == 0 then "Pling" else ""
    plang = if number % 5 == 0 then "Plang" else ""
    plong = if number % 7 == 0 then "Plong" else ""
    result = "$(pling)$(plang)$(plong)"
    if result == "" then
        Num.toStr number
    else
        result
