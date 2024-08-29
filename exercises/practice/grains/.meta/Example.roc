module [grainsOnSquare, totalGrains]

grainsOnSquare = \square ->
    if square > 0 && square <= 64 then
        2 |> Num.powInt (square - 1) |> Ok
        # or: 1u64 |> Num.shiftLeftBy (square - 1) |> Ok
    else
        Err SquareMustBeBetween1And64

totalGrains =
    Num.maxU64
# or: 0xFFFFFFFFFFFFFFFF
# or: 2u128 |> Num.powInt 64 |> Num.sub 1
# or: 1u128 |> Num.shiftLeftBy 64 |> Num.sub 1
# or:
#     List.range { start: At 1u64, end: At 64u64 }
#     |> List.map \g -> grainsOnSquare g |> Result.withDefault 0
#     |> List.sum
