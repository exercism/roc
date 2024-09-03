module [grainsOnSquare, totalGrains]

grainsOnSquare : U8 -> Result U64 [SquareMustBeBetween1And64]
grainsOnSquare = \square ->
    if square > 0 && square <= 64 then
        2u64 |> Num.powInt (Num.toU64 square - 1) |> Ok
    else
        Err SquareMustBeBetween1And64

totalGrains : U64
totalGrains =
    Num.maxU64
