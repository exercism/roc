module [steps]

steps = \number ->
    if number <= 0 then
        Err (NumberArgWasNotPositive number)
    else if number == 1 then
        Ok 0
    else if Num.isEven number then
        Ok ((steps? (number // 2)) + 1)
    else
        Ok ((steps? (3 * number + 1)) + 1)
