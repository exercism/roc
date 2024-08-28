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

verse = \index ->
    blablabla =
        segments
        |> List.takeFirst index
        |> List.reverse
        |> Str.joinWith " the "
    "This is the $(blablabla)"

recite = \startVerse, endVerse ->
    List.range { start: At startVerse, end: At endVerse }
    |> List.map verse
    |> Str.joinWith "\n"
