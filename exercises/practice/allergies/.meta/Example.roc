module [allergicTo, set]

Allergen : [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]

allergicTo : Allergen, U64 -> Bool
allergicTo = \allergen, score ->
    set score
    |> Set.contains allergen

set : U64 -> Set Allergen
set = \score ->
    [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]
    |> List.walk { bits: score, allergies: Set.empty {} } \{ bits, allergies }, allergy ->
        updatedAllergies = if bits % 2 == 0 then allergies else allergies |> Set.insert allergy
        { bits: bits // 2, allergies: updatedAllergies }
    |> .allergies
