module [score]

Category : [Ones, Twos, Threes, Fours, Fives, Sixes, FullHouse, FourOfAKind, LittleStraight, BigStraight, Choice, Yacht]

score_ones_to_sixes : List U8, U8 -> U8
score_ones_to_sixes = \dice, value ->
    dice |> List.keepIf (\die -> die == value) |> List.sum

value_counts : List U8 -> List U8
value_counts = \dice ->
    dice
    |> List.walk [0, 0, 0, 0, 0, 0] \counts, die ->
        counts |> List.update (die - 1 |> Num.toU64) \x -> x + 1

score_full_house : List U8 -> U8
score_full_house = \dice ->
    if dice |> value_counts |> Set.fromList == Set.fromList [0, 2, 3] then
        dice |> List.sum
    else
        0

score_four_of_a_kind : List U8 -> U8
score_four_of_a_kind = \dice ->
    dice
    |> value_counts
    |> List.walkWithIndexUntil 0 \_, count, index ->
        if count < 4 then Continue 0 else (index + 1 |> Num.toU8) * 4 |> Break

score_straight : List U8, List U8 -> U8
score_straight = \dice, target ->
    if dice |> List.sortAsc == target then 30 else 0

score : List U8, Category -> U8
score = \dice, category ->
    if dice |> List.len != 5 || dice |> List.any \die -> die < 1 || die > 6 then
        0
        else

    when category is
        Ones -> dice |> score_ones_to_sixes 1
        Twos -> dice |> score_ones_to_sixes 2
        Threes -> dice |> score_ones_to_sixes 3
        Fours -> dice |> score_ones_to_sixes 4
        Fives -> dice |> score_ones_to_sixes 5
        Sixes -> dice |> score_ones_to_sixes 6
        FullHouse -> dice |> score_full_house
        FourOfAKind -> dice |> score_four_of_a_kind
        LittleStraight -> dice |> score_straight [1, 2, 3, 4, 5]
        BigStraight -> dice |> score_straight [2, 3, 4, 5, 6]
        Choice -> dice |> List.sum
        Yacht -> if dice |> Set.fromList |> Set.len == 1 then 50 else 0