module [isArmstrongNumber]

listDigits = \number ->
    if number < 10 then
        [number]
    else
        (listDigits (number // 10)) |> List.append (number % 10)

isArmstrongNumber : U64 -> Bool
isArmstrongNumber = \number ->
    digits = listDigits number
    len = List.len digits
    candidate =
        digits
        |> List.map (\digit -> digit |> Num.powInt len)
        |> List.sum
    candidate == number
