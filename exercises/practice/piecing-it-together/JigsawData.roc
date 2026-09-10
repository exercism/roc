JigsawData := { pieces : U64, border : U64, inside : U64, rows : U64, columns : U64, aspect_ratio : Dec, format : JigsawData.Format }.{
	Format : [Square, Portrait, Landscape]

	PartialJigsawData := { pieces ?: U64, border ?: U64, inside ?: U64, rows ?: U64, columns ?: U64, aspect_ratio ?: Dec, format ?: Format }

	create : PartialJigsawData -> Try(JigsawData, _)
	create = |partial_jigsaw_data| {
		crash "Please implement the 'create' function"
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _
}
