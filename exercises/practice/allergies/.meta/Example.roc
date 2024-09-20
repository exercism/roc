module [allergicTo, list]

Allergen : [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]

allergicTo : Allergen, U64 -> Bool
allergicTo = \allergen, score ->
    list score
    |> Set.contains allergen

list : U64 -> Set Allergen
list = \score ->
    removeLargePowers = \s ->
        if s >= 256 then
            removeLargePowers (s - largestPowerOfTwo s)
        else
            s

    List.walk values { set: Set.empty {}, remaining: removeLargePowers score } \{ set, remaining }, { allergen, value } ->
        if value <= remaining then
            { set: Set.insert set allergen, remaining: remaining - value }
        else
            { set, remaining }
    |> .set

largestPowerOfTwo : U64 -> U64
largestPowerOfTwo = \number ->
    help = \remaining, power ->
        if remaining < 2 then
            power
        else
            help (remaining // 2) (power * 2)
    help number 1

values : List { allergen : Allergen, value : U64 }
values =
    [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]
    |> List.mapWithIndex \allergen, index ->
        { allergen, value: Num.powInt 2 index }
    |> List.reverse
