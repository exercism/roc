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
		if (first, second) == (Black, Black) return Ohms(0)
		value = if second == Black {
			get_code(first)
		} else {
			10 * get_code(first) + get_code(second)
		}
		pow = get_code(third) + if second == Black {
			1
		} else {
			0
		}
		match pow {
			0 => Ohms(value)
			1 => Ohms(value * 10)
			2 => Ohms(value * 100)
			3 => Kiloohms(value)
			4 => Kiloohms(value * 10)
			5 => Kiloohms(value * 100)
			6 => Megaohms(value)
			7 => Megaohms(value * 10)
			8 => Megaohms(value * 100)
			9 => Gigaohms(value)
			10 => Gigaohms(value * 10)
			_ => {
				crash "Unreachable"
			}
		}
	}
}

get_code : Color -> U16
get_code = |color| {
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
