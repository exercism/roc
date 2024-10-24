module [ownsZebra, drinksWater]

Person : [Englishman, Spaniard, Ukrainian, Norwegian, Japanese]

House : {
    activity : U8, # 0 = Undefined, 1 = Dancing, 2 = Painting, 3 = Reading, 4 = Football, 5 = Chess
    animal : U8, # 0 = Undefined, 1 = Dog, 2 = Snail, 3 = Fox, 4 = Horse, 5 = Zebra
    color : U8, # 0 = Undefined, 1 = Red, 2 = Green, 3 = Ivory, 4 = Yellow, 5 = Blue
    drink : U8, # 0 = Undefined, 1 = Coffee, 2 = Tea, 3 = Milk, 4 = OrangeJuice, 5 = Water
    person : U8, # 0 = Undefined, 1 = Englishman, 2 = Spaniard, 3 = Ukrainian, 4 = Norwegian, 5 = Japanese
}

ownsZebra : Result Person [NotFound]
ownsZebra =
    ownerOf \house -> house.animal == 5

drinksWater : Result Person [NotFound]
drinksWater =
    ownerOf \house -> house.drink == 5

ownerOf : (House -> Bool) -> Result Person [NotFound]
ownerOf = \condition ->
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
    numHouses = 5 # rule 1
    findFirstSolution = \houses, house, fieldIndex ->
        [1, 2, 3, 4, 5]
        |> List.walkUntil (Err NotFound) \state, value ->
            updatedHouse = house |> setField fieldIndex value
            updatedHouses = houses |> List.append updatedHouse
            if updatedHouses |> isValid then
                if List.len updatedHouses == numHouses && fieldIndex == 4 then
                    Break (Ok updatedHouses)
                    else

                (nextHouses, nextHouse, nextFieldIndex) =
                    if fieldIndex == 4 then
                        (updatedHouses, initHouse, 0)
                    else
                        (houses, updatedHouse, fieldIndex + 1)

                when findFirstSolution nextHouses nextHouse nextFieldIndex is
                    Ok found -> Break (Ok found)
                    Err NotFound -> Continue state
            else
                Continue state
    initHouse = { activity: 0, animal: 0, color: 0, drink: 0, person: 0 }
    findFirstSolution [] initHouse 0

setField : House, U8, U8 -> House
setField = \house, fieldIndex, value ->
    when fieldIndex is
        0 -> { house & activity: value }
        1 -> { house & animal: value }
        2 -> { house & color: value }
        3 -> { house & drink: value }
        4 -> { house & person: value }
        _ -> crash "fieldIndex should always be between 0 and 4"

isValid : List House -> Bool
isValid = \houses ->
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

sameHouse : List House, (House -> U8, U8), (House -> U8, U8) -> Bool
sameHouse = \houses, (field1, value1), (field2, value2) ->
    houses
    |> List.all \house ->
        f1 = field1 house
        f2 = field2 house
        (f1 == 0 || f2 == 0) || (f1 == value1 && f2 == value2) || (f1 != value1 && f2 != value2)

# The Englishman lives in the red house.
rule2 : List House -> Bool
rule2 = \houses ->
    houses |> sameHouse (.person, 1) (.color, 1)

# The Spaniard owns the dog.
rule3 : List House -> Bool
rule3 = \houses ->
    houses |> sameHouse (.person, 2) (.animal, 1)

# The person in the green house drinks coffee.
rule4 : List House -> Bool
rule4 = \houses ->
    houses |> sameHouse (.color, 2) (.drink, 1)

# The Ukrainian drinks tea.
rule5 : List House -> Bool
rule5 = \houses ->
    houses |> sameHouse (.person, 3) (.drink, 2)

# The green house is immediately to the right of the ivory house.
rule6 : List House -> Bool
rule6 = \houses ->
    greenHouse = houses |> List.findFirstIndex \house -> house.color == 2
    ivoryHouse = houses |> List.findFirstIndex \house -> house.color == 3
    when (greenHouse, ivoryHouse) is
        (Ok greenIndex, Ok ivoryIndex) -> greenIndex == ivoryIndex + 1
        _ -> Bool.true

# The snail owner likes to go dancing.
rule7 : List House -> Bool
rule7 = \houses ->
    houses |> sameHouse (.animal, 2) (.activity, 1)

# The person in the yellow house is a painter.
rule8 : List House -> Bool
rule8 = \houses ->
    houses |> sameHouse (.color, 4) (.activity, 2)

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
    readerHouse = houses |> List.findFirstIndex \house -> house.activity == 3
    foxHouse = houses |> List.findFirstIndex \house -> house.animal == 3
    when (readerHouse, foxHouse) is
        (Ok readerIndex, Ok foxIndex) -> (readerIndex == foxIndex + 1) || (foxIndex == readerIndex + 1)
        _ -> Bool.true

# The painter's house is next to the house with the horse.
rule12 : List House -> Bool
rule12 = \houses ->
    painterHouse = houses |> List.findFirstIndex \house -> house.activity == 2
    horseHouse = houses |> List.findFirstIndex \house -> house.animal == 4
    when (painterHouse, horseHouse) is
        (Ok painterIndex, Ok horseIndex) -> (painterIndex == horseIndex + 1) || (horseIndex == painterIndex + 1)
        _ -> Bool.true

# The List person -> Bool
rule13 : List House -> Bool
rule13 = \houses ->
    houses |> sameHouse (.activity, 4) (.drink, 4)

# The List Japanese -> Bool
rule14 : List House -> Bool
rule14 = \houses ->
    houses |> sameHouse (.person, 5) (.activity, 5)

# The Norwegian lives next to the blue house.
rule15 : List House -> Bool
rule15 = \houses ->
    norwegianHouse = houses |> List.findFirstIndex \house -> house.person == 4
    blueHouse = houses |> List.findFirstIndex \house -> house.color == 5
    when (norwegianHouse, blueHouse) is
        (Ok norwegianIndex, Ok blueIndex) -> (norwegianIndex == blueIndex + 1) || (blueIndex == norwegianIndex + 1)
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
