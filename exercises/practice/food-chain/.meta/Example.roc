FoodChain :: {}.{
	recite : U64, U64 -> Str
	recite = |start_verse, end_verse| {
		verse_list
			.sublist({ start: start_verse - 1, len: end_verse - (start_verse - 1) })
			->Str.join_with("\n\n")
	}
}

verse_list : List(Str)
verse_list = {
	initial_state = { verses: [], verse_body: "I don't know why she swallowed the fly. Perhaps she'll die.", previous_animal: "fly" }
	result = 
		animals.fold(
			initial_state,
			|{ verses, verse_body, previous_animal }, animal| {
				description = animal_descriptions.get(previous_animal) ?? ""
				new_verse_body = "She swallowed the ${animal.name} to catch the ${previous_animal}${description}.\n${verse_body}"
				verse = "I know an old lady who swallowed a ${animal.name}.\n${animal.exclamation}\n${new_verse_body}"
				{
					verses: verses.append(verse),
					verse_body: new_verse_body,
					previous_animal: animal.name,
				}
			},
		)
	[first_verse].concat(result.verses).concat([last_verse])
}

# I would prefer to use an if expression here, but I ran into a compiler bug doing that
animal_descriptions : Dict(Str, Str)
animal_descriptions = 
	Dict.single("spider", " that wriggled and jiggled and tickled inside her")

animals : List({ name : Str, exclamation : Str })
animals = [
	{ name: "spider", exclamation: "It wriggled and jiggled and tickled inside her." },
	{ name: "bird", exclamation: "How absurd to swallow a bird!" },
	{ name: "cat", exclamation: "Imagine that, to swallow a cat!" },
	{ name: "dog", exclamation: "What a hog, to swallow a dog!" },
	{ name: "goat", exclamation: "Just opened her throat and swallowed a goat!" },
	{ name: "cow", exclamation: "I don't know how she swallowed a cow!" },
]

first_verse : Str
first_verse = "I know an old lady who swallowed a fly.\nI don't know why she swallowed the fly. Perhaps she'll die."

last_verse : Str
last_verse = "I know an old lady who swallowed a horse.\nShe's dead, of course!"
