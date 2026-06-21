SimpleLinkedList :: [Nil, Cons(U64, SimpleLinkedList)].{
	from_list : List(U64) -> SimpleLinkedList
	from_list = |list| {
		crash "Please implement the 'from_list' function"
	}

	to_list : SimpleLinkedList -> List(U64)
	to_list = |linked_list| {
		crash "Please implement the 'to_list' function"
	}

	push : SimpleLinkedList, U64 -> SimpleLinkedList
	push = |linked_list, item| {
		crash "Please implement the 'push' function"
	}

	pop : SimpleLinkedList -> Try({ value : U64, updated_list : SimpleLinkedList }, [LinkedListWasEmpty])
	pop = |linked_list| {
		crash "Please implement the 'pop' function"
	}

	peek : SimpleLinkedList -> Try(U64, [LinkedListWasEmpty])
	peek = |linked_list| {
		crash "Please implement the 'peek' function"
	}

	reverse : SimpleLinkedList -> SimpleLinkedList
	reverse = |linked_list| {
		crash "Please implement the 'reverse' function"
	}

	len : SimpleLinkedList -> U64
	len = |linked_list| {
		crash "Please implement the 'len' function"
	}
}
