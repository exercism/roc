Resistor := [Ohms(Dec), Kiloohms(Dec), Megaohms(Dec), Gigaohms(Dec)].{
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

	decode_colors : Color, Color, Color -> Resistor
	decode_colors = |first, second, third| {
		crash "Please implement the 'decode_colors' function"
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _
}
