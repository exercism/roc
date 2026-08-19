ResistorColorTrio :: {}.{
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

	Label : [Ohms(U16), Kiloohms(U16), Megaohms(U16), Gigaohms(U16)]

	label : Color, Color, Color -> Label
	label = |first, second, third| {
		crash "Please implement the 'label' function"
	}
}
