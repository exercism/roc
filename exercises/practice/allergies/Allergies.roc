module [allergicTo, list]

Allergen : [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]

allergicTo : Allergen, U64 -> Bool
allergicTo = \allergen, score ->
    crash "Please implement 'allergicTo'"

list : U64 -> Set Allergen
list = \score ->
    crash "Please implement 'list'"
