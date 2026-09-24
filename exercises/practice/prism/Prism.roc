Prism := { id : U64, x : Dec, y : Dec, angle : Dec }.{
	find_sequence : { start : { x : Dec, y : Dec, angle : Dec }, prisms : List(Prism) } -> List(U64)
	find_sequence = |{ start, prisms }| {
		crash "Please implement the 'find_sequence' function"
	}
}
