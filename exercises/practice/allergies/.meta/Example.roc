module [allergic_to, set]

Allergen : [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]

allergic_to : Allergen, U64 -> Bool
allergic_to = |allergen, score|
    set(score)
    |> Set.contains(allergen)

set : U64 -> Set Allergen
set = |score|
    [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]
    |> List.walk(
        { bits: score, allergies: Set.empty({}) },
        |{ bits, allergies }, allergy|
            updated_allergies = if bits % 2 == 0 then allergies else allergies |> Set.insert(allergy)
            { bits: bits // 2, allergies: updated_allergies },
    )
    |> .allergies
