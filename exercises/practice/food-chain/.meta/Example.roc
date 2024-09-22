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
            firstLine = "I know an old lady who swallowed a $(animal.name)."
            newVerseBody =
                """
                She swallowed the $(animal.name) to catch the $(previousAnimal)$(Dict.get animalDescriptions previousAnimal |> Result.withDefault "").
                $(verseBody)
                """
            verse =
                when animal.exclamation is
                    Ok e -> [firstLine, e, newVerseBody] |> Str.joinWith "\n"
                    Err _ -> [firstLine, newVerseBody] |> Str.joinWith "\n"

            { verses: List.append verses verse, verseBody: newVerseBody, previousAnimal: animal.name }
    List.join [[firstVerse], result.verses, [lastVerse]]

animalDescriptions =
    Dict.single "spider" " that wriggled and jiggled and tickled inside her"

animals = [
    { name: "spider", exclamation: Ok "It wriggled and jiggled and tickled inside her." },
    { name: "bird", exclamation: Ok "How absurd to swallow a bird!" },
    { name: "cat", exclamation: Ok "Imagine that, to swallow a cat!" },
    { name: "dog", exclamation: Ok "What a hog, to swallow a dog!" },
    { name: "goat", exclamation: Ok "Just opened her throat and swallowed a goat!" },
    { name: "cow", exclamation: Ok "I don't know how she swallowed a cow!" },
]

firstVerse =
    """
    I know an old lady who swallowed a fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    """

lastVerse =
    """
    I know an old lady who swallowed a horse.
    She's dead, of course!
    """
