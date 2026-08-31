KillerSudokuHelper :: {}.{
	Combination : List(U8)

	ArgsWithDefaultExclude := { sum : U8, size : U8, exclude : List(U8) ?? [] }

	combinations : ArgsWithDefaultExclude -> List(Combination)
	combinations = |{ sum, size, exclude }| {
		crash "Please implement the 'combinations' function"
	}
}
