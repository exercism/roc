TwelveDays :: {}.{
	recite : U8, U8 -> Try(Str, [InvalidVerseNumber, ..])
	recite = |first_verse, last_verse| {
		if first_verse == 0 or last_verse == 0 or first_verse > last_verse {
			Err(InvalidVerseNumber)
		} else {
			(first_verse..=last_verse)
				|> List.from_iter
				.map_try(verse)?
				|> Str.join_with("\n")
				|> Ok
		}
	}
}

verse : U8 -> Try(Str, [InvalidVerseNumber, ..])
verse = |day| {
	Ok("On the ${to_ordinal(day)?} day of Christmas my true love gave to me: ${presents(day)?}.")
}

present : U8 -> Try(Str, [InvalidVerseNumber, ..])
present = |number| {
	match number {
		1 => Ok("a Partridge in a Pear Tree")
		2 => Ok("two Turtle Doves")
		3 => Ok("three French Hens")
		4 => Ok("four Calling Birds")
		5 => Ok("five Gold Rings")
		6 => Ok("six Geese-a-Laying")
		7 => Ok("seven Swans-a-Swimming")
		8 => Ok("eight Maids-a-Milking")
		9 => Ok("nine Ladies Dancing")
		10 => Ok("ten Lords-a-Leaping")
		11 => Ok("eleven Pipers Piping")
		12 => Ok("twelve Drummers Drumming")
		_ => Err(InvalidVerseNumber)
	}
}

presents : U8 -> Try(Str, [InvalidVerseNumber, ..])
presents = |day| {
	(1..=day)
		|> List.from_iter
		.rev()
		.map_try(present)?
		|> Str.join_with(", ")
		|> (|str| if day > 1 {
			str.replace_first(", a", ", and a")
		} else {
			str
		})
		|> Ok
}

to_ordinal : U8 -> Try(Str, [InvalidVerseNumber, ..])
to_ordinal = |day| {
	match day {
		1 => Ok("first")
		2 => Ok("second")
		3 => Ok("third")
		4 => Ok("fourth")
		5 => Ok("fifth")
		6 => Ok("sixth")
		7 => Ok("seventh")
		8 => Ok("eighth")
		9 => Ok("ninth")
		10 => Ok("tenth")
		11 => Ok("eleventh")
		12 => Ok("twelfth")
		_ => Err(InvalidVerseNumber)
	}
}
