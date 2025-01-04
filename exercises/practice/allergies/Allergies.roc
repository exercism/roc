module [allergic_to, set]

Allergen : [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]

allergic_to : Allergen, U64 -> Bool
allergic_to = \allergen, score ->
    crash "Please implement 'allergic_to'"

set : U64 -> Set Allergen
set = \score ->
    crash "Please implement 'set'"
