KindergartenGarden :: {}.{
	Student := [Alice, Bob, Charlie, David, Eve, Fred, Ginny, Harriet, Ileana, Joseph, Kincaid, Larry]
	Plant := [Grass, Clover, Radishes, Violets]

	plants : Str, Student -> Try(List(Plant), [UnknownPlant(U8), OutOfBounds])
	plants = |diagram, student| {
		start_index = 2 * student_index(student)
		grid = diagram.to_utf8().split_on('\n')
		[(0, 0), (0, 1), (1, 0), (1, 1)]
			->map_try(
				|(row, column)| {
					plant = grid.get(row)?.get(start_index + column)?
					match plant {
						'G' => Ok(Grass)
						'C' => Ok(Clover)
						'R' => Ok(Radishes)
						'V' => Ok(Violets)
						_ => Err(UnknownPlant(plant))
					}
				},
			)
	}
}

student_index : Student -> U64
student_index = |student| {
	match student {
		Alice => 0
		Bob => 1
		Charlie => 2
		David => 3
		Eve => 4
		Fred => 5
		Ginny => 6
		Harriet => 7
		Ileana => 8
		Joseph => 9
		Kincaid => 10
		Larry => 11
	}
}

map_try = |iter, func| {
	var $state = []
	for item in iter {
		$state = $state.append(func(item)?)
	}
	Ok($state)
}
