Resistor := {
    resistance: [Ohms(Dec), Kiloohms(Dec), Megaohms(Dec), Gigaohms(Dec)]
    tolerance ?: Dec,
}.{
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
        Silver,
        Gold,
	]

    decode_colors : List(Color) -> Try(Resistor, _)
    decode_colors = |colors| {
        crash "Please implement the 'decode_colors' function"
    }

	# The following line enables the default `is_eq` implementation
	is_eq : _
}
