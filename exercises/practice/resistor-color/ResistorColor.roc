ResistorColor :: {}.{
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

	color_code : Color -> U8
	color_code = |color| {
		crash "Please implement the 'color_code' function"
	}

	colors : List(Color)
	colors = {
		crash "Please implement the 'colors' function"
	}
}
