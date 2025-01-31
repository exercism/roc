module [grains_on_square, total_grains]

grains_on_square : U8 -> Result U64 [SquareArgWasNotBetween1And64 U8]
grains_on_square = |square|
    if square > 0 and square <= 64 then
        2u64 |> Num.pow_int((Num.to_u64(square) - 1)) |> Ok
    else
        Err(SquareArgWasNotBetween1And64(square))

total_grains : U64
total_grains =
    Num.max_u64
