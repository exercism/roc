module [recite]

recite : U64, U64 -> Str
recite = \startVerse, endVerse ->
    List.sublist verseList { start: startVerse - 1, len: endVerse - (startVerse - 1) }
    |> Str.joinWith "\n\n"

verseList : List Str
verseList =
    initialState = { verses: [], verseBody: "I don't know why she swallowed the fly. Perhaps she'll die.", previousAnimal: "fly" }
    result =
        List.walk animals initialState \{ verses, verseBody, previousAnimal }, animal ->
            description = Dict.get animalDescriptions previousAnimal |> Result.withDefault ""
            newVerseBody =
                """
                She swallowed the $(animal.name) to catch the $(previousAnimal)$(description).
                $(verseBody)
                """
            verse =
                """
                I know an old lady who swallowed a $(animal.name).
                $(animal.exclamation)
                $(newVerseBody)
                """
            {
                verses: List.append verses verse,
                verseBody: newVerseBody,
                previousAnimal: animal.name,
            }
    List.join [[firstVerse], result.verses, [lastVerse]]

# I would prefer to use an if expression here, but I ran into a compiler bug doing that
animalDescriptions : Dict Str Str
animalDescriptions =
    Dict.single "spider" " that wriggled and jiggled and tickled inside her"

animals : List { name : Str, exclamation : Str }
animals = [
    { name: "spider", exclamation: "It wriggled and jiggled and tickled inside her." },
    { name: "bird", exclamation: "How absurd to swallow a bird!" },
    { name: "cat", exclamation: "Imagine that, to swallow a cat!" },
    { name: "dog", exclamation: "What a hog, to swallow a dog!" },
    { name: "goat", exclamation: "Just opened her throat and swallowed a goat!" },
    { name: "cow", exclamation: "I don't know how she swallowed a cow!" },
]

firstVerse : Str
firstVerse =
    """
    I know an old lady who swallowed a fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    """

lastVerse : Str
lastVerse =
    """
    I know an old lady who swallowed a horse.
    She's dead, of course!
    """
