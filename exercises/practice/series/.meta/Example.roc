Series :: {}.{
	slices : Str, U64 -> List(Str)
	slices = |string, slice_length| {
		chars = string.to_utf8()
		len = chars.len()
		if len == 0 or slice_length == 0 or slice_length > len {
			[]
		} else {
			maybe_list =
				(
					(0..=(len - slice_length))
						|> List.from_iter,
				).map_try(
					|start_index| {
						chars
							.sublist(
								{ start: start_index, len: slice_length },
							)
							|> Str.from_utf8
					},
				)
			match maybe_list {
				Ok(list) => list
				Err(BadUtf8(_)) => {
					crash "Only ASCII strings are supported"
				}
			}
		}
	}
}
