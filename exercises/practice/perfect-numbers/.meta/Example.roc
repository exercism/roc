module [classify]

aliquotSum = \number ->
    if number <= 0 then
        Err (NumberArgWasNotPositive number)
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

classify = \number ->
    sum = aliquotSum? number
    if sum == number then
        Ok Perfect
    else if sum > number then
        Ok Abundant
    else
        Ok Deficient
