ListOps :: {}.{
	# # Note: this function is named "append" in the exercise instructions
	# # but Roc prefers to name this "concat"
	concat : List(a), List(a) -> List(a)
	concat = |list1, list2| {
		crash "Please implement the 'concat' function"
	}

	# # Note: this function is named "concatenate" in the exercise instructions
	# # but Roc prefers to name this "join"
	join : List(List(a)) -> List(a)
	join = |lists| {
		crash "Please implement the 'join' function"
	}

	filter : List(a), (a -> Bool) -> List(a)
	filter = |list, function| {
		crash "Please implement the 'filter' function"
	}

	# # Note: this function is named "length" in the exercise instructions
	# # but Roc prefers to name this "len"
	len : List(a) -> U64
	len = |list| {
		crash "Please implement the 'len' function"
	}

	map : List(a), (a -> b) -> List(b)
	map = |list, function| {
		crash "Please implement the 'map' function"
	}

	# # Note: this function is named "foldl" in the exercise instructions
	# # but Roc prefers to name this "fold"
	fold : List(a), b, (b, a -> b) -> b
	fold = |list, initial, function| {
		crash "Please implement the 'fold' function"
	}

	# # Note: this function is named "foldr" in the exercise instructions
	# # but Roc prefers to name this "fold_rev"
	fold_rev : List(a), b, (b, a -> b) -> b
	fold_rev = |list, initial, function| {
		crash "Please implement the 'fold_rev' function"
	}

	reverse : List(a) -> List(a)
	reverse = |list| {
		crash "Please implement the 'reverse' function"
	}
}
