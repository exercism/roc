Hamming :: {}.{
	distance : Str, Str -> Try(U64, [StrandArgsWereNotOfEqualLength(Str, Str)])
	distance = |strand1, strand2| {
		crash "Please implement the 'distance' function"
	}
}
