module [recite]

segments = [
    "house that Jack built.",
    "malt that lay in",
    "rat that ate",
    "cat that killed",
    "dog that worried",
    "cow with the crumpled horn that tossed",
    "maiden all forlorn that milked",
    "man all tattered and torn that kissed",
    "priest all shaven and shorn that married",
    "rooster that crowed in the morn that woke",
    "farmer sowing his corn that kept",
    "horse and the hound and the horn that belonged to",
]

verse = |index|
    blablabla =
        segments
        |> List.take_first(index)
        |> List.reverse
        |> Str.join_with(" the ")
    "This is the ${blablabla}"

recite : U64, U64 -> Str
recite = |start_verse, end_verse|
    List.range({ start: At(start_verse), end: At(end_verse) })
    |> List.map(verse)
    |> Str.join_with("\n")
