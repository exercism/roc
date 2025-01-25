module [recite]

recite : U64, U64 -> Str
recite = |start_verse, end_verse|
    List.sublist(verse_list, { start: start_verse - 1, len: end_verse - (start_verse - 1) })
    |> Str.join_with("\n\n")

verse_list : List Str
verse_list =
    initial_state = { verses: [], verse_body: "I don't know why she swallowed the fly. Perhaps she'll die.", previous_animal: "fly" }
    result =
        List.walk(
            animals,
            initial_state,
            |{ verses, verse_body, previous_animal }, animal|
                description = Dict.get(animal_descriptions, previous_animal) |> Result.with_default("")
                new_verse_body =
                    """
                    She swallowed the ${animal.name} to catch the ${previous_animal}${description}.
                    ${verse_body}
                    """
                verse =
                    """
                    I know an old lady who swallowed a ${animal.name}.
                    ${animal.exclamation}
                    ${new_verse_body}
                    """
                {
                    verses: List.append(verses, verse),
                    verse_body: new_verse_body,
                    previous_animal: animal.name,
                },
        )
    List.join([[first_verse], result.verses, [last_verse]])

# I would prefer to use an if expression here, but I ran into a compiler bug doing that
animal_descriptions : Dict Str Str
animal_descriptions =
    Dict.single("spider", " that wriggled and jiggled and tickled inside her")

animals : List { name : Str, exclamation : Str }
animals = [
    { name: "spider", exclamation: "It wriggled and jiggled and tickled inside her." },
    { name: "bird", exclamation: "How absurd to swallow a bird!" },
    { name: "cat", exclamation: "Imagine that, to swallow a cat!" },
    { name: "dog", exclamation: "What a hog, to swallow a dog!" },
    { name: "goat", exclamation: "Just opened her throat and swallowed a goat!" },
    { name: "cow", exclamation: "I don't know how she swallowed a cow!" },
]

first_verse : Str
first_verse =
    """
    I know an old lady who swallowed a fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    """

last_verse : Str
last_verse =
    """
    I know an old lady who swallowed a horse.
    She's dead, of course!
    """
