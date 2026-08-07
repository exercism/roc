import unicode.Grapheme

MicroBlog :: {}.{
	GraphemeErrors : [
		CodepointTooLarge,
		EncodesSurrogateHalf,
		ExpectedContinuation,
		InvalidUtf8,
		ListWasEmpty,
		OverlongEncoding,
	]

	truncate : Str -> Try(Str, GraphemeErrors)
	truncate = |input| {
		input
			|> Grapheme.owned
			.take_first(5)
			|> Str.join_with("")
			|> Ok
	}
}
