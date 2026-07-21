AtbashCipher :: {}.{
	encode : Str -> Try(Str, _)
	encode = |phrase| {
		phrase
			.to_utf8()
			->join_map(
				|char| {
					if char >= 'A' and char <= 'Z' {
						[invert((char - 'A' + 'a'))]
					} else if char >= 'a' and char <= 'z' {
						[invert(char)]
					} else if char >= '0' and char <= '9' {
						[char]
					} else {
						[]
					}
				},
			)
			->chunks_of(5)
			->intersperse([' '])
			->join()
			->Str.from_utf8()
	}

	decode : Str -> Try(Str, _)
	decode = |phrase| {
		phrase
			.to_utf8()
			.drop_if(
				|c| {
					c == ' '
				},
			)
			.map(
				invert,
			)
			->Str.from_utf8()
	}
}

invert : U8 -> U8
invert = |char| {
	if char >= 'a' and char <= 'z' {
		'z' - char + 'a'
	} else {
		char
	}
}

# The following functions should soon be available in Roc's builtins
chunks_of = |list, size| {
	var $state = []
	var $chunk = []
	for item in list {
		$chunk = $chunk.append(item)
		if $chunk.len() == size.to_u64() {
			$state = $state.append($chunk)
			$chunk = []
		}
	}
	if $chunk.len() > 0 {
		$state = $state.append($chunk)
	}
	$state
}

intersperse = |list, sep| {
	var $res = []
	for item in list {
		$res = $res.concat([item, sep])
	}
	$res.drop_last(1)
}

join = |list| {
	var $state = []
	for sublist in list {
		for item in sublist {
			$state = $state.append(item)
		}
	}
	$state
}

join_map = |list, func| {
	var $state = []
	for item in list {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}

fold_try = |list, init, func| {
	var $state = init
	for item in list {
		$state = func($state, item)?
	}
	Ok($state)
}

sort_asc = |list| {
	list.sort_with(|a, b| a.compare(b))
}

sort_desc = |list| {
	list.sort_with(|a, b| b.compare(a))
}
