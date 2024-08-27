module [steps]

steps = \n ->
    if n <= 0 then
        Err "Only positive integers are allowed"
    else if n == 1 then
        Ok 0
    else if Num.isEven n then
        Ok ((steps? (n // 2)) + 1)
    else
        Ok ((steps? (3 * n + 1)) + 1)
