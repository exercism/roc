JigsawData := { pieces : U64, border : U64, inside : U64, rows : U64, columns : U64, aspect_ratio : F64, format : JigsawData.Format }.{
	Format : [Square, Portrait, Landscape]

	PartialJigsawData := { pieces ?: U64, border ?: U64, inside ?: U64, rows ?: U64, columns ?: U64, aspect_ratio ?: F64, format ?: Format }

	create : PartialJigsawData -> Try(JigsawData, _)
	create = |data| {
		match (data.?rows, data.?columns) {
			# If we have both rows and columns, we can compute all other fields and check that they match existing fields
			(Ok(rows), Ok(columns)) => {
				if rows == 0 or columns == 0 {
					return Err(InvalidData)
				}
				pieces = rows * columns
				border = 2 * (rows + columns) - 4
				inside = if rows < 3 or columns < 3 {
					0
				} else {
					(rows - 2) * (columns - 2)
				}
				aspect_ratio = columns.to_f64() / rows.to_f64()
				format = if aspect_ratio < 1 {
					Portrait
				} else if aspect_ratio > 1 {
					Landscape
				} else {
					Square
				}
				if ((data.?pieces ?? pieces) != pieces or
					(data.?border ?? border) != border or
						(data.?inside ?? inside) != inside or
							(data.?aspect_ratio ?? aspect_ratio) != aspect_ratio or
								(data.?format ?? format) != format) {
					return Err(InvalidData)
				}
				return Ok({ pieces, border, inside, rows, columns, aspect_ratio, format })
			}
			_ => {}
		}
		# If we have the aspect ratio, we can infer the format
		match (data.?format, data.?aspect_ratio) {
			(Err(MissingField), Ok(ratio)) => {
				format = if ratio < 1 {
					Portrait
				} else if ratio > 1 {
					Landscape
				} else {
					Square
				}
				return create({ ..data, format })
			}
			_ => {}
		}
		# If the format is Square, then rows == columns
		match (data.?format, data.?rows, data.?columns) {
			(Ok(Square), Err(MissingField), Ok(columns)) => {
				return create({ ..data, rows: columns })
			}
			(Ok(Square), Ok(rows), Err(MissingField)) => {
				return create({ ..data, columns: rows })
			}
			_ => {}
		}
		# If the format is Square and we know the number of inside pieces, we can infer rows and columns
		match (data.?format, data.?inside) {
			(Ok(Square), Ok(inside)) => {
				rows = data.?rows ?? ((inside.to_f64().sqrt().round_to_u64_try() ?? 0) + 2)
				columns = data.?columns ?? rows
				return create({ ..data, rows, columns })
			}
			_ => {}
		}
		# If we have the number of pieces and the aspect ratio, we can infer rows and columns
		match (data.?pieces, data.?aspect_ratio) {
			(Ok(pieces), Ok(ratio)) => {
				columns = data.?columns ?? ((pieces.to_f64() * ratio.to_f64()).to_f64().sqrt().round_to_u64_try() ?? 0)
				if columns == 0 {
					return Err(InvalidData)
				}
				rows = data.?rows ?? (pieces / columns)
				return create({ ..data, rows, columns })
			}
			_ => {}
		}
		# If we have the aspect ratio and either rows or columns, we can infer the other
		match (data.?rows, data.?columns, data.?aspect_ratio) {
			(Ok(rows), Err(MissingField), Ok(ratio)) => {
				columns = (rows.to_f64() * ratio).round_to_u64_try() ?? 0
				return create({ ..data, columns })
			}
			(Err(MissingField), Ok(columns), Ok(ratio)) => {
				if ratio == 0 {
					return Err(InvalidData)
				}
				rows = (columns.to_f64() / ratio).round_to_u64_try() ?? 0
				return create({ ..data, rows })
			}
			_ => {}
		}
		# If we have the total number of pieces and the number of border pieces, we can infer
		# the two side lengths. The format lets us orient the jigsaw puzzle approprietely
		match (data.?pieces, data.?border, data.?format) {
			(Ok(pieces), Ok(border), Ok(format)) => {
				sum = (border + 4) / 2 # == rows + columns
				prod = pieces # == rows * columns
				root_delta = (sum * sum - 4 * prod).to_f64().sqrt().round_to_u64_try() ?? 0
				short = (sum - root_delta) / 2
				long = (sum + root_delta) / 2
				match format {
					Portrait | Square => return create({ ..data, rows: long, columns: short })
					Landscape => return create({ ..data, rows: short, columns: long })
				}
			}
			_ => {}
		}
		Err(InvalidData)
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _
}
