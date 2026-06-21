SimpleLinkedList :: [Nil, Cons(U64, SimpleLinkedList)].{
	from_list : List(U64) -> SimpleLinkedList
	from_list = |list| list.fold(Nil, push)

	to_list : SimpleLinkedList -> List(U64)
	to_list = |linked_list| {
		match linked_list {
			Nil => []
			Cons(head, tail) => tail.to_list().append(head)
		}
	}

	push : SimpleLinkedList, U64 -> SimpleLinkedList
	push = |linked_list, item| Cons(item, linked_list)

	pop : SimpleLinkedList -> Try({ value : U64, updated_list : SimpleLinkedList }, [LinkedListWasEmpty])
	pop = |linked_list| {
		match linked_list {
			Nil => Err(LinkedListWasEmpty)
			Cons(head, tail) => Ok({ value: head, updated_list: tail })
		}
	}

	peek : SimpleLinkedList -> Try(U64, [LinkedListWasEmpty])
	peek = |linked_list| {
		match linked_list {
			Nil => Err(LinkedListWasEmpty)
			Cons(head, _) => Ok(head)
		}
	}

	reverse : SimpleLinkedList -> SimpleLinkedList
	reverse = |linked_list| {
		help = |result, rest| {
			match rest {
				Nil => result
				Cons(head, tail) => help((result->push(head)), tail)
			}
		}
		help(Nil, linked_list)
	}

	len : SimpleLinkedList -> U64
	len = |linked_list| {
		match linked_list {
			Nil => 0
			Cons(_, tail) => 1 + tail.len()
		}
	}
}
