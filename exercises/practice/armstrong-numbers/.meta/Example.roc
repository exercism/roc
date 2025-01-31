module [is_armstrong_number]

list_digits = |number|
    if number < 10 then
        [number]
    else
        (list_digits((number // 10))) |> List.append((number % 10))

is_armstrong_number : U64 -> Bool
is_armstrong_number = |number|
    digits = list_digits(number)
    len = List.len(digits)
    candidate =
        digits
        |> List.map(|digit| digit |> Num.pow_int(len))
        |> List.sum
    candidate == number
