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

    label_decoder : List(Color) -> Try(Resistor, _)
    label_decoder = |colors| {
        crash "Please implement the 'label_decoder' function"
    }

	# The following line enables the default `is_eq` implementation
	is_eq : _
}
