##
## Example solution
##

import unicode.Scalar

MicroBlog :: {}.{
	truncate : Str -> Try(Str, [InternalEncodingFault])
	truncate = |input| {
		Scalar.iter(input)
			.take_first(5)
			|> List.from_iter
			.map_try(|{ scalar, .. }| scalar.to_str())?
			|> Str.join_with("")
			|> Ok
	}
}
