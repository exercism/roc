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

collect = |iter| {
	var $state = []
	for item in iter {
		$state = $state.append(item)
	}
	$state
}

intersperse = |list, sep| {
	match list {
		[] => []
		[_] => list
		[first, .. as rest] => [first, sep].concat(intersperse(rest, sep))
	}
}

join = |iter| {
	var $state = []
	for sublist in iter {
		for item in sublist {
			$state = $state.append(item)
		}
	}
	$state
}

join_map = |iter, func| {
	var $state = []
	for item in iter {
		for subitem in func(item) {
			$state = $state.append(subitem)
		}
	}
	$state
}
