module [steps]

steps = \n ->
    if n == 1 then
        0
    else if Num.isEven n then
        (steps (n // 2)) + 1
    else
        (steps (3 * n + 1)) + 1

