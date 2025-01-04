module [classify]

aliquot_sum : U64 -> Result U64 [NumberArgIsZero]
aliquot_sum = \number ->
    if number == 0 then
        Err NumberArgIsZero
    else if number == 1 then
        Ok 0 # edge case
    else
        Ok
            (
                # There are more efficient algorithms, but this is the simplest
                List.range { start: At 1, end: At (number // 2) }
                |> List.keepIf \d -> number % d == 0
                |> List.sum
            )

classify : U64 -> Result [Abundant, Deficient, Perfect] [NumberArgIsZero]
classify = \number ->
    sum = aliquot_sum? number
    if sum == number then
        Ok Perfect
    else if sum > number then
        Ok Abundant
    else
        Ok Deficient
