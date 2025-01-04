module [owns_zebra, drinks_water]

Person : [Englishman, Spaniard, Ukrainian, Norwegian, Japanese]

House : {
    activity : U8, # 0 = Undefined, 1 = Dancing, 2 = Painting, 3 = Reading, 4 = Football, 5 = Chess
    animal : U8, # 0 = Undefined, 1 = Dog, 2 = Snail, 3 = Fox, 4 = Horse, 5 = Zebra
    color : U8, # 0 = Undefined, 1 = Red, 2 = Green, 3 = Ivory, 4 = Yellow, 5 = Blue
    drink : U8, # 0 = Undefined, 1 = Coffee, 2 = Tea, 3 = Milk, 4 = OrangeJuice, 5 = Water
    person : U8, # 0 = Undefined, 1 = Englishman, 2 = Spaniard, 3 = Ukrainian, 4 = Norwegian, 5 = Japanese
}

owns_zebra : Result Person [NotFound]
owns_zebra =
    owner_of \house -> house.animal == 5

drinks_water : Result Person [NotFound]
drinks_water =
    owner_of \house -> house.drink == 5

owner_of : (House -> Bool) -> Result Person [NotFound]
owner_of = \condition ->
    when solution is
        Ok houses ->
            when houses |> List.findFirst? condition |> .person is
                1 -> Ok Englishman
                2 -> Ok Spaniard
                3 -> Ok Ukrainian
                4 -> Ok Norwegian
                5 -> Ok Japanese
                _ -> Err NotFound

        Err NotFound -> Err NotFound

solution : Result (List House) [NotFound]
solution =
    num_houses = 5 # rule 1
    find_first_solution = \houses, house, field_index ->
        [1, 2, 3, 4, 5]
        |> List.walkUntil (Err NotFound) \state, value ->
            updated_house = house |> set_field field_index value
            updated_houses = houses |> List.append updated_house
            if updated_houses |> is_valid then
                if List.len updated_houses == num_houses && field_index == 4 then
                    Break (Ok updated_houses)
                    else

                (next_houses, next_house, next_field_index) =
                    if field_index == 4 then
                        (updated_houses, init_house, 0)
                    else
                        (houses, updated_house, field_index + 1)

                when find_first_solution next_houses next_house next_field_index is
                    Ok found -> Break (Ok found)
                    Err NotFound -> Continue state
            else
                Continue state
    init_house = { activity: 0, animal: 0, color: 0, drink: 0, person: 0 }
    find_first_solution [] init_house 0

set_field : House, U8, U8 -> House
set_field = \house, field_index, value ->
    when field_index is
        0 -> { house & activity: value }
        1 -> { house & animal: value }
        2 -> { house & color: value }
        3 -> { house & drink: value }
        4 -> { house & person: value }
        _ -> crash "field_index should always be between 0 and 4"

is_valid : List House -> Bool
is_valid = \houses ->
    [
        rule2,
        rule3,
        rule4,
        rule5,
        rule6,
        rule7,
        rule8,
        rule9,
        rule10,
        rule11,
        rule12,
        rule13,
        rule14,
        rule15,
        rule16,
    ]
    |> List.all \rule -> rule houses

same_house : List House, (House -> U8, U8), (House -> U8, U8) -> Bool
same_house = \houses, (field1, value1), (field2, value2) ->
    houses
    |> List.all \house ->
        f1 = field1 house
        f2 = field2 house
        (f1 == 0 || f2 == 0) || (f1 == value1 && f2 == value2) || (f1 != value1 && f2 != value2)

# The Englishman lives in the red house.
rule2 : List House -> Bool
rule2 = \houses ->
    houses |> same_house (.person, 1) (.color, 1)

# The Spaniard owns the dog.
rule3 : List House -> Bool
rule3 = \houses ->
    houses |> same_house (.person, 2) (.animal, 1)

# The person in the green house drinks coffee.
rule4 : List House -> Bool
rule4 = \houses ->
    houses |> same_house (.color, 2) (.drink, 1)

# The Ukrainian drinks tea.
rule5 : List House -> Bool
rule5 = \houses ->
    houses |> same_house (.person, 3) (.drink, 2)

# The green house is immediately to the right of the ivory house.
rule6 : List House -> Bool
rule6 = \houses ->
    green_house = houses |> List.findFirstIndex \house -> house.color == 2
    ivory_house = houses |> List.findFirstIndex \house -> house.color == 3
    when (green_house, ivory_house) is
        (Ok green_index, Ok ivory_index) -> green_index == ivory_index + 1
        _ -> Bool.true

# The snail owner likes to go dancing.
rule7 : List House -> Bool
rule7 = \houses ->
    houses |> same_house (.animal, 2) (.activity, 1)

# The person in the yellow house is a painter.
rule8 : List House -> Bool
rule8 = \houses ->
    houses |> same_house (.color, 4) (.activity, 2)

# The person in the middle house drinks milk.
rule9 : List House -> Bool
rule9 = \houses ->
    houses
    |> List.mapWithIndex \house, index -> (house, index)
    |> List.all \(house, index) ->
        (house.drink == 0) || (index == 2 && house.drink == 3) || (index != 2 && house.drink != 3)

# The Norwegian lives in the first house.
rule10 : List House -> Bool
rule10 = \houses ->
    houses
    |> List.mapWithIndex \house, index -> (house, index)
    |> List.all \(house, index) ->
        (house.person == 0) || (index == 0 && house.person == 4) || (index != 0 && house.person != 4)

# The person who enjoys reading lives in the house next to the person with the fox.
rule11 : List House -> Bool
rule11 = \houses ->
    reader_house = houses |> List.findFirstIndex \house -> house.activity == 3
    fox_house = houses |> List.findFirstIndex \house -> house.animal == 3
    when (reader_house, fox_house) is
        (Ok reader_index, Ok fox_index) -> (reader_index == fox_index + 1) || (fox_index == reader_index + 1)
        _ -> Bool.true

# The painter's house is next to the house with the horse.
rule12 : List House -> Bool
rule12 = \houses ->
    painter_house = houses |> List.findFirstIndex \house -> house.activity == 2
    horse_house = houses |> List.findFirstIndex \house -> house.animal == 4
    when (painter_house, horse_house) is
        (Ok painter_index, Ok horse_index) -> (painter_index == horse_index + 1) || (horse_index == painter_index + 1)
        _ -> Bool.true

# The List person -> Bool
rule13 : List House -> Bool
rule13 = \houses ->
    houses |> same_house (.activity, 4) (.drink, 4)

# The List Japanese -> Bool
rule14 : List House -> Bool
rule14 = \houses ->
    houses |> same_house (.person, 5) (.activity, 5)

# The Norwegian lives next to the blue house.
rule15 : List House -> Bool
rule15 = \houses ->
    norwegian_house = houses |> List.findFirstIndex \house -> house.person == 4
    blue_house = houses |> List.findFirstIndex \house -> house.color == 5
    when (norwegian_house, blue_house) is
        (Ok norwegian_index, Ok blue_index) -> (norwegian_index == blue_index + 1) || (blue_index == norwegian_index + 1)
        _ -> Bool.true

rule16 : List House -> Bool
rule16 = \houses ->
    [.activity, .animal, .color, .drink, .person]
    |> List.all \field ->
        values =
            houses
            |> List.map field
            |> List.keepIf \value -> value != 0
        List.len values == Set.len (Set.fromList values)