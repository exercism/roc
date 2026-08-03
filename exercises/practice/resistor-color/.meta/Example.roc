ResistorColor :: {}.{
	colors : List(Str)
	colors = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]

	color_code : Str -> Try(U64, [NotFound])
	color_code = |color| {
		colors.find_first_index(|elem| elem == color)
	}
}
