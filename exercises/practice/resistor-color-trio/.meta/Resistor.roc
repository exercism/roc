##
## Example solution
##

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
		if (first, second) == (Black, Black) return Ohms(0)
		value = color_code(first) * 10 + color_code(second)
		multiplier = Dec.pow(10, color_code(third))
		resistance = value * multiplier
		if resistance < 1e3 {
			Ohms(resistance)
		} else if resistance < 1e6 {
			Kiloohms(resistance / 1e3)
		} else if resistance < 1e9 {
			Megaohms(resistance / 1e6)
		} else  {
			Gigaohms(resistance / 1e9)
		}
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _
}

color_code : Color -> Dec
color_code = |color| {
	match color {
		Black => 0
		Brown => 1
		Red => 2
		Orange => 3
		Yellow => 4
		Green => 5
		Blue => 6
		Violet => 7
		Grey => 8
		White => 9
	}
}
