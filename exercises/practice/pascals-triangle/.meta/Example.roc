module [pascals_triangle]

pascals_triangle : U64 -> List (List U64)
pascals_triangle = |count|
    List.range({ start: At(0), end: Before(count) })
    |> List.map(
        |row|
            List.range({ start: At(0), end: At(row) })
            |> List.map(|column| binomial_coefficient(row, column)),
    )

binomial_coefficient : U64, U64 -> U64
binomial_coefficient = |n, k|
    if k == 0 or k == n then
        1
    else
        numerator =
            List.range({ start: At((n + 1 - k)), end: At(n) })
            |> List.walk(1, |product, value| product * value)
        denominator =
            List.range({ start: At(1), end: At(k) })
            |> List.walk(1, |product, value| product * value)
        numerator // denominator
