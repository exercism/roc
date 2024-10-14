module [pascalsTriangle]

pascalsTriangle : U64 -> List (List U64)
pascalsTriangle = \count ->
    List.range { start: At 0, end: Before count }
    |> List.map \row ->
        List.range { start: At 0, end: At row }
        |> List.map \column -> binomialCoefficient row column

binomialCoefficient : U64, U64 -> U64
binomialCoefficient = \n, k ->
    if k == 0 || k == n then
        1
        else

    numerator =
        List.range { start: At (n + 1 - k), end: At n }
        |> List.walk 1 \product, value -> product * value
    denominator =
        List.range { start: At 1, end: At k }
        |> List.walk 1 \product, value -> product * value
    numerator // denominator
