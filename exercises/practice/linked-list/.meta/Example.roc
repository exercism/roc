# Logical order is front.rev() followed by back; both ends use list append/remove-last.
Deque :: { front : List(U64), back : List(U64) }.{

	## Create an empty deque
	empty : () -> Deque
	empty = || Deque.{ front: [], back: [] }

	## Add a value at the end of the deque
	append : Deque, U64 -> Deque
	append = |deque, value| { ..deque, back: deque.back.append(value) }

	## Remove the last value and return it with the updated deque, or Err(DequeWasEmpty)
	pop_last : Deque -> Try({ deque : Deque, value : U64 }, [DequeWasEmpty, ..])
	pop_last = |deque| {
		removed = remove_last(deque.back, deque.front)?
		Ok({ deque: { front: removed.opposite, back: removed.remaining }, value: removed.value })
	}

	## Add a value at the start of the deque
	prepend : Deque, U64 -> Deque
	prepend = |deque, value| { ..deque, front: deque.front.append(value) }

	## Remove the first value and return it with the updated deque, or Err(DequeWasEmpty)
	pop_first : Deque -> Try({ deque : Deque, value : U64 }, [DequeWasEmpty, ..])
	pop_first = |deque| {
		removed = remove_last(deque.front, deque.back)?
		Ok({ deque: { front: removed.remaining, back: removed.opposite }, value: removed.value })
	}

	## Remove the first occurrence of a value, leaving the deque unchanged if absent
	remove_value : Deque, U64 -> Deque
	remove_value = |deque, value| {
		match deque.front.find_last_index(|item| item == value) {
			Ok(index) => { ..deque, front: deque.front.drop_at(index) }
			Err(NotFound) => match deque.back.find_first_index(|item| item == value) {
				Ok(index) => { ..deque, back: deque.back.drop_at(index) }
				Err(NotFound) => deque
			}
		}
	}

	## Return the number of values in the deque
	len : Deque -> U64
	len = |deque| deque.front.len() + deque.back.len()
}

remove_last : List(U64), List(U64) -> Try({ remaining : List(U64), opposite : List(U64), value : U64 }, [DequeWasEmpty, ..])
remove_last = |items, opposite| {
	match items {
		[.. as remaining, value] => Ok({ remaining, opposite, value })
		[] => {
			if opposite.is_empty() {
				Err(DequeWasEmpty)
			} else {
				# Split rather than reverse everything, so alternating ends stay cheap.
				moved = (opposite.len() + 1) // 2
				remove_last(opposite.take_first(moved).rev(), opposite.drop_first(moved))
			}
		}
	}
}
