ParallelLetterFrequency :: {}.{
	calculate_frequencies! : { texts : List(Str), workers : U64 } => Try(Dict(Str, U64), _)
	calculate_frequencies! = |{ texts, workers }| {
		crash "Please implement the 'calculate_frequencies!' function"
	}
}
