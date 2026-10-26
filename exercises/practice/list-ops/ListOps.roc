ListOps :: {}.{
	concat : List(a), List(a) -> List(a)
	concat = |list1, list2| {
		crash "Please implement the 'concat' function"
	}

	join : List(List(a)) -> List(a)
	join = |lists| {
		crash "Please implement the 'join' function"
	}

	filter : List(a), (a -> Bool) -> List(a)
	filter = |list, function| {
		crash "Please implement the 'filter' function"
	}

	len : List(a) -> U64
	len = |list| {
		crash "Please implement the 'len' function"
	}

	map : List(a), (a -> b) -> List(b)
	map = |list, function| {
		crash "Please implement the 'map' function"
	}

	fold : List(a), b, (b, a -> b) -> b
	fold = |list, initial, function| {
		crash "Please implement the 'fold' function"
	}

	fold_rev : List(a), b, (b, a -> b) -> b
	fold_rev = |list, initial, function| {
		crash "Please implement the 'fold_rev' function"
	}

	reverse : List(a) -> List(a)
	reverse = |list| {
		crash "Please implement the 'reverse' function"
	}
}
