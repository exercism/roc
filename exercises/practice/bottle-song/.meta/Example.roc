BottleSong :: {}.{
	recite : U8, U8 -> Try(Str, [InvalidVerseNumber, ..])
	recite = |starting_number, number_of_verses| {
		if starting_number == 0 or number_of_verses == 0 or starting_number < number_of_verses {
			Err(InvalidVerseNumber)
		} else {
			((starting_number - number_of_verses + 1)..=starting_number)
				.iter()
				|> List.from_iter
				.rev()
				.map_try(verse)?
				|> Str.join_with("\n\n")
				|> Ok
		}
	}
}

verse : U8 -> Try(Str, [InvalidVerseNumber, ..])
verse = |number| {
	\\${describe_bottles(number, Uppercase)?} hanging on the wall,
	\\${describe_bottles(number, Uppercase)?} hanging on the wall,
	\\And if one green bottle should accidentally fall,
	\\There'll be ${describe_bottles(number - 1, Lowercase)?} hanging on the wall.
		|> Ok
}

describe_bottles : U8, [Uppercase, Lowercase] -> Try(Str, [InvalidVerseNumber, ..])
describe_bottles = |number, case| {
	if number > 10 {
		return Err(InvalidVerseNumber)
	}
	number_str_upper : Str
	number_str_upper = match number {
		0 => "No"
		1 => "One"
		2 => "Two"
		3 => "Three"
		4 => "Four"
		5 => "Five"
		6 => "Six"
		7 => "Seven"
		8 => "Eight"
		9 => "Nine"
		10 => "Ten"
		_ => crash "Unreachable"
	}

	number_str : Str
	number_str = match case {
		Uppercase => number_str_upper
		Lowercase => number_str_upper |> lowercase_first_letter
	}

	maybe_s : Str
	maybe_s = if number != 1 {
		"s"
	} else {
		""
	}

	Ok("${number_str} green bottle${maybe_s}")
}

lowercase_first_letter : Str -> Str
lowercase_first_letter = |str| {
	match str.to_utf8() {
		[first, .. as rest] if first >= 'A' and first <= 'Z' => Str.from_utf8(rest.prepend(first - 'A' + 'a')) ?? {
			crash "Unreachable"
		}
		_ => str
	}
}
