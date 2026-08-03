ResistorColor :: {}.{
	color_code : Str -> Try(U64, [NotFound])
	color_code = |color| {
		crash "Please implement the 'color_code' function"
	}

	colors : List(Str)
	colors = {
		crash "Please implement the 'colors' function"
	}
}
