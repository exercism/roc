OcrNumbers :: {}.{
	convert : Str -> Try(Str, BadGridSize)
	convert = |grid| {
		if grid == "" {
			Ok("")
		} else {
			grid_chars = grid.to_utf8().split_on('\n')
			size = check_size(grid_chars)?
			digits_str = 
				grid_chars
					->chunks_of(4)
					.map(
						|row_group| {
							get_digit_grids(row_group, size.width)
								.map(identify_digit)
								->Str.join_with("")
						},
					)
					->Str.join_with(",")
			Ok(digits_str)
		}
	}
}

BadGridSize : [HeightWasNotAMultipleOf4, WidthWasNotAMultipleOf3, GridShapeWasNotRectangular]

check_size : List(List(U8)) -> Try({ height : U64, width : U64 }, BadGridSize)
check_size = |grid_chars| {
	height = grid_chars.len()
	if height % 4 != 0 {
		Err(HeightWasNotAMultipleOf4)
	} else {
		width = grid_chars.map(List.len).fold(
			0,
			|max_val, len| if len > max_val {
				len
			} else {
				max_val
			},
		)
		if width % 3 != 0 {
			Err(WidthWasNotAMultipleOf3)
		} else {
			is_rectangular = grid_chars.all(|row| row.len() == width)
			if is_rectangular {
				Ok({ height, width })
			} else {
				Err(GridShapeWasNotRectangular)
			}
		}
	}
}

## Given four rows from the full grid, return the 3x4 grid for each digit
get_digit_grids : List(List(U8)), U64 -> List(List(List(U8)))
get_digit_grids = |row_group, full_grid_width| {
	chunked_rows = row_group.map(|row| row->chunks_of(3))
	num_horizontal_chunks = full_grid_width // 3
	(0..<num_horizontal_chunks)
		.map(
			|chunk_index| {
				chunked_rows
					.map(
						|chunked_row| {
							match chunked_row.get(chunk_index) {
								Ok(chunk) => chunk
								Err(OutOfBounds) => {
									crash "Unreachable: we checked the grid size"
								}
							}
						},
					)
			},
		)
		->List.from_iter()
}

identify_digit : List(List(U8)) -> Str
identify_digit = |digit_grid| {
	match digit_grid {
		[[' ', '_', ' '], ['|', ' ', '|'], ['|', '_', '|'], [' ', ' ', ' ']] => "0"
		[[' ', ' ', ' '], [' ', ' ', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] => "1"
		[[' ', '_', ' '], [' ', '_', '|'], ['|', '_', ' '], [' ', ' ', ' ']] => "2"
		[[' ', '_', ' '], [' ', '_', '|'], [' ', '_', '|'], [' ', ' ', ' ']] => "3"
		[[' ', ' ', ' '], ['|', '_', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] => "4"
		[[' ', '_', ' '], ['|', '_', ' '], [' ', '_', '|'], [' ', ' ', ' ']] => "5"
		[[' ', '_', ' '], ['|', '_', ' '], ['|', '_', '|'], [' ', ' ', ' ']] => "6"
		[[' ', '_', ' '], [' ', ' ', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] => "7"
		[[' ', '_', ' '], ['|', '_', '|'], ['|', '_', '|'], [' ', ' ', ' ']] => "8"
		[[' ', '_', ' '], ['|', '_', '|'], [' ', '_', '|'], [' ', ' ', ' ']] => "9"
		_ => "?"
	}
}

# The following functions should soon be available in Roc's builtins
chunks_of = |iter, size| {
	var $state = []
	var $chunk = []
	for item in iter {
		$chunk = $chunk.append(item)
		if $chunk.len() == size {
			$state = $state.append($chunk)
			$chunk = []
		}
	}
	if $chunk.len() > 0 {
		$state = $state.append($chunk)
	}
	$state
}
