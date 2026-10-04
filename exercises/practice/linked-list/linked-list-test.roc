# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/linked-list/canonical-data.json
# File last updated on 2026-09-20

import Deque

# pop_last gets element from the list
expect {
	deque = Deque.empty()
		.append(7)
		.pop_last()?
		|> expected_value(7)?
	deque.len() == 0
}

# append/pop_last respectively add/remove at the end of the list
expect {
	deque = Deque.empty()
		.append(11)
		.append(13)
		.pop_last()?
		|> expected_value(13)?
		.pop_last()?
		|> expected_value(11)?
	deque.len() == 0
}

# pop_first gets an element from the list
expect {
	deque = Deque.empty()
		.append(17)
		.pop_first()?
		|> expected_value(17)?
	deque.len() == 0
}

# pop_first gets first element from the list
expect {
	deque = Deque.empty()
		.append(23)
		.append(5)
		.pop_first()?
		|> expected_value(23)?
		.pop_first()?
		|> expected_value(5)?
	deque.len() == 0
}

# prepend adds element at start of the list
expect {
	deque = Deque.empty()
		.prepend(23)
		.prepend(5)
		.pop_first()?
		|> expected_value(5)?
		.pop_first()?
		|> expected_value(23)?
	deque.len() == 0
}

# pop_last, append, pop_first, and prepend can be used in any order
expect {
	deque = Deque.empty()
		.append(1)
		.append(2)
		.pop_last()?
		|> expected_value(2)?
		.append(3)
		.pop_first()?
		|> expected_value(1)?
		.prepend(4)
		.append(5)
		.pop_first()?
		|> expected_value(4)?
		.pop_last()?
		|> expected_value(5)?
		.pop_first()?
		|> expected_value(3)?
	deque.len() == 0
}

# len of an empty list
expect {
	deque = Deque.empty()
	deque.len() == 0
}

# len of a list with items
expect {
	deque = Deque.empty()
		.append(37)
		.append(1)
	deque.len() == 2
}

# len is correct after mutation
expect {
	deque = Deque.empty()
		.append(31)
		|> expected_len(1)?
		.prepend(43)
		|> expected_len(2)?
		.pop_first()?.deque
		|> expected_len(1)?
		.pop_last()?.deque
	deque.len() == 0
}

# removing from the end to empty doesn't break the list
expect {
	deque = Deque.empty()
		.append(41)
		.append(59)
		.pop_last()?.deque
		.pop_last()?.deque
		.append(47)
		|> expected_len(1)?
		.pop_last()?
		|> expected_value(47)?
	deque.len() == 0
}

# removing from the start to empty doesn't break the list
expect {
	deque = Deque.empty()
		.append(41)
		.append(59)
		.pop_first()?.deque
		.pop_first()?.deque
		.append(47)
		|> expected_len(1)?
		.pop_first()?
		|> expected_value(47)?
	deque.len() == 0
}

# remove_value removes the only element
expect {
	deque = Deque.empty()
		.append(61)
		.remove_value(61)
	deque.len() == 0
}

# remove_value removes the element with the specified value from the list
expect {
	deque = Deque.empty()
		.append(71)
		.append(83)
		.append(79)
		.remove_value(83)
		|> expected_len(2)?
		.pop_last()?
		|> expected_value(79)?
		.pop_first()?
		|> expected_value(71)?
	deque.len() == 0
}

# remove_value removes the element with the specified value from the list, re-assigns tail
expect {
	deque = Deque.empty()
		.append(71)
		.append(83)
		.append(79)
		.remove_value(83)
		|> expected_len(2)?
		.pop_last()?
		|> expected_value(79)?
		.pop_last()?
		|> expected_value(71)?
	deque.len() == 0
}

# remove_value removes the element with the specified value from the list, re-assigns head
expect {
	deque = Deque.empty()
		.append(71)
		.append(83)
		.append(79)
		.remove_value(83)
		|> expected_len(2)?
		.pop_first()?
		|> expected_value(71)?
		.pop_first()?
		|> expected_value(79)?
	deque.len() == 0
}

# remove_value removes the first of two elements
expect {
	deque = Deque.empty()
		.append(97)
		.append(101)
		.remove_value(97)
		|> expected_len(1)?
		.pop_last()?
		|> expected_value(101)?
	deque.len() == 0
}

# remove_value removes the second of two elements
expect {
	deque = Deque.empty()
		.append(97)
		.append(101)
		.remove_value(101)
		|> expected_len(1)?
		.pop_last()?
		|> expected_value(97)?
	deque.len() == 0
}

# remove_value does not modify the list if the element is not found
expect {
	deque = Deque.empty()
		.append(89)
		.remove_value(103)
	deque.len() == 1
}

# remove_value removes only the first occurrence
expect {
	deque = Deque.empty()
		.append(73)
		.append(9)
		.append(9)
		.append(107)
		.remove_value(9)
		|> expected_len(3)?
		.pop_last()?
		|> expected_value(107)?
		.pop_last()?
		|> expected_value(9)?
		.pop_last()?
		|> expected_value(73)?
	deque.len() == 0
}

expected_value = |result, value| {
	if result.value == value {
		Ok(result.deque)
	} else {
		Err(UnexpectedValue)
	}
}

expected_len = |deque, length| {
	if deque.len() == length {
		Ok(deque)
	} else {
		Err(UnexpectedLength)
	}
}
