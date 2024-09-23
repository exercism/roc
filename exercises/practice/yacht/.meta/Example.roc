module [score]

Category : [Ones, Twos, Threes, Fours, Fives, Sixes, FullHouse, FourOfAKind, LittleStraight, BigStraight, Choice, Yacht]

scoreOnesToSixes : List U8, U8 -> U8
scoreOnesToSixes = \dice, value ->
    dice |> List.keepIf (\die -> die == value) |> List.sum

valueCounts : List U8 -> List U8
valueCounts = \dice ->
    dice
    |> List.walk [0, 0, 0, 0, 0, 0] \counts, die ->
        counts |> List.update (die - 1 |> Num.toU64) \x -> x + 1

scoreFullHouse : List U8 -> U8
scoreFullHouse = \dice ->
    if dice |> valueCounts |> Set.fromList == Set.fromList [0, 2, 3] then
        dice |> List.sum
    else
        0

scoreFourOfAKind : List U8 -> U8
scoreFourOfAKind = \dice ->
    dice
    |> valueCounts
    |> List.walkWithIndexUntil 0 \_, count, index ->
        if count < 4 then Continue 0 else (index + 1 |> Num.toU8) * 4 |> Break

scoreStraight : List U8, List U8 -> U8
scoreStraight = \dice, target ->
    if dice |> List.sortAsc == target then 30 else 0

score : List U8, Category -> U8
score = \dice, category ->
    if dice |> List.len != 5 || dice |> List.any \die -> die < 1 || die > 6 then
        0
        else

    when category is
        Ones -> dice |> scoreOnesToSixes 1
        Twos -> dice |> scoreOnesToSixes 2
        Threes -> dice |> scoreOnesToSixes 3
        Fours -> dice |> scoreOnesToSixes 4
        Fives -> dice |> scoreOnesToSixes 5
        Sixes -> dice |> scoreOnesToSixes 6
        FullHouse -> dice |> scoreFullHouse
        FourOfAKind -> dice |> scoreFourOfAKind
        LittleStraight -> dice |> scoreStraight [1, 2, 3, 4, 5]
        BigStraight -> dice |> scoreStraight [2, 3, 4, 5, 6]
        Choice -> dice |> List.sum
        Yacht -> if dice |> Set.fromList |> Set.len == 1 then 50 else 0
