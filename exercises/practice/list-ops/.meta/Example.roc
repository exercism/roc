ListOps :: {}.{
	concat : List(a), List(a) -> List(a)
	concat = |list1, list2| {
		match list2 {
			[] => list1
			[first, .. as rest] => concat(list1.append(first), rest)
		}
	}

	join : List(List(a)) -> List(a)
	join = |lists| {
		match lists {
			[] => []
			[first, .. as rest] => first->concat(join(rest))
		}
	}

	filter : List(a), (a -> Bool) -> List(a)
	filter = |list, function| {
		loop = |l, acc| {
			match l {
				[] => acc
				[first, .. as rest] => {
					if function(first) {
						loop(rest, acc.append(first))
					} else {
						loop(rest, acc)
					}
				}
			}
		}

		loop(list, [])
	}

	len : List(a) -> U64
	len = |list| {
		loop = |l, acc| {
			match l {
				[] => acc
				[_, .. as rest] => loop(rest, (acc + 1))
			}
		}
		loop(list, 0)
	}

	map : List(a), (a -> b) -> List(b)
	map = |list, function| {
		loop = |l, acc| {
			match l {
				[] => acc
				[first, .. as rest] => loop(rest, acc.append(function(first)))
			}
		}
		loop(list, [])
	}

	fold : List(a), b, (b, a -> b) -> b
	fold = |list, initial, function| {
		match list {
			[] => initial
			[first, .. as rest] => fold(rest, function(initial, first), function)
		}
	}

	fold_rev : List(a), b, (b, a -> b) -> b
	fold_rev = |list, initial, function| {
		match list {
			[] => initial
			[.. as rest, last] => fold_rev(rest, function(initial, last), function)
		}
	}

	reverse : List(a) -> List(a)
	reverse = |list| {
		loop = |l, acc| {
			match l {
				[] => acc
				[.. as rest, last] => loop(rest, acc.append(last))
			}
		}
		loop(list, [])
	}
}
