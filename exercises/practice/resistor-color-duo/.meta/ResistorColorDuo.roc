##
## Example solution
##

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
		10 * color_code(first) + color_code(second)
	}
}

color_code : Color -> U8
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
