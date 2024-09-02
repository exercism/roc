module [steps]

steps : U64 -> Result U64 [NumberArgWasZero]
steps = \number ->
    if number <= 0 then
        Err NumberArgWasZero
    else if number == 1 then
        Ok 0
    else if Num.isEven number then
        Ok ((steps? (number // 2)) + 1)
    else
        Ok ((steps? (3 * number + 1)) + 1)
