module [allergicTo, set]

Allergen : [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]

allergicTo : Allergen, U64 -> Bool
allergicTo = \allergen, score ->
    crash "Please implement 'allergicTo'"

set : U64 -> Set Allergen
set = \score ->
    crash "Please implement 'set'"
