House :: {}.{
	recite : U64, U64 -> Str
	recite = |start_verse, end_verse| {
		(start_verse..=end_verse)
			.map(verse)
			->List.from_iter()
			->Str.join_with("\n")
	}
}

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

verse = |index| {
	blablabla = 
		segments
			.take_first(index)
			->reverse()
			->Str.join_with(" the ")
	"This is the ${blablabla}"
}

# List.reverse should soon be available in Roc's builtins
reverse : List(a) -> List(a)
reverse = |list| {
	match list {
		[] => []
		[first, .. as rest] => reverse(rest).append(first)
	}
}
