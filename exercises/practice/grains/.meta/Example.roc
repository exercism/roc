module [grains_on_square, total_grains]

grains_on_square : U8 -> Result U64 [SquareArgWasNotBetween1And64 U8]
grains_on_square = \square ->
    if square > 0 && square <= 64 then
        2u64 |> Num.powInt (Num.toU64 square - 1) |> Ok
    else
        Err (SquareArgWasNotBetween1And64 square)

total_grains : U64
total_grains =
    Num.maxU64
