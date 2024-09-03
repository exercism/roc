module [grainsOnSquare, totalGrains]

grainsOnSquare : U8 -> Result U64 [SquareArgWasNotBetween1And64 U8]
grainsOnSquare = \square ->
    if square > 0 && square <= 64 then
        2u64 |> Num.powInt (Num.toU64 square - 1) |> Ok
    else
        Err (SquareArgWasNotBetween1And64 square)

totalGrains : U64
totalGrains =
    Num.maxU64
