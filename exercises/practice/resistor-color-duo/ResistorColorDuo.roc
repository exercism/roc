ResistorColorDuo :: {}.{
	Color : [
		Black,
		Brown,
		Red,
		Orange,
		Yellow,
		Green,
		Blue,
		Violet,
		Grey,
		White,
	]

	decode_colors : Color, Color -> U8
	decode_colors = |first, second| {
		crash "Please implement the 'decode_colors' function"
	}
}
