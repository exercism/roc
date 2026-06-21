# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/simple-linked-list/canonical-data.json
# File last updated on 2026-06-21

import SimpleLinkedList

##
## count
##

# Empty list has length of zero
expect {
	result = 
		SimpleLinkedList.from_list([])
			.len()

	result == 0
}

# Singleton list has length of one
expect {
	result = 
		SimpleLinkedList.from_list([1])
			.len()

	result == 1
}

# Non-empty list has correct length
expect {
	result = 
		SimpleLinkedList.from_list([1, 2, 3])
			.len()

	result == 3
}

##
## pop
##

# Pop from empty list is an error
expect {
	result = 
		SimpleLinkedList.from_list([])
			.pop()

	result.is_err()
}

# Can pop from singleton list
expect {
	result = 
		SimpleLinkedList.from_list([1])
			.pop()?
			.value

	result == 1
}

# Can pop from non-empty list
expect {
	result = 
		SimpleLinkedList.from_list([1, 2])
			.pop()?
			.value

	result == 2
}

# Can pop multiple items
expect {
	result = 
		SimpleLinkedList.from_list([1, 2])
			.pop()?
			->expect_value(2)?
			.pop()?
			.value

	result == 1
}

# Pop updates the count
expect {
	result1 = 
		SimpleLinkedList.from_list([1, 2])
			->expect_len(2)?
			.pop()?
			->expect_value(2)?
	result2 =  # TODO: remove this workaround when the roc bug is fixed.
		result1
			->expect_len(1)?
			.pop()?
			->expect_value(1)?
			.len()

	result2 == 0
}

##
## push
##

# Push updates count
expect {
	result = 
		SimpleLinkedList.from_list([1, 2])
			.push(3)
			.len()

	result == 3
}

# Push and pop
expect {
	result = 
		SimpleLinkedList.from_list([])
			.push(1)
			.push(2)
			.pop()?
			->expect_value(2)?
			.push(3)
			->expect_len(2)?
			.pop()?
			->expect_value(3)?
			.pop()?
			->expect_value(1)?
			.len()

	result == 0
}

##
## peek
##

# Peek on empty list is an error
expect {
	result = 
		SimpleLinkedList.from_list([])
			.peek()

	result.is_err()
}

# Can peek on singleton list
expect {
	result = 
		SimpleLinkedList.from_list([1])
			.peek()?

	result == 1
}

# Can peek on non-empty list
expect {
	result = 
		SimpleLinkedList.from_list([1, 2])
			.peek()?

	result == 2
}

# Peek does not change the count
expect {
	result = 
		SimpleLinkedList.from_list([1, 2])
			->expect_peek(2)?
			.len()

	result == 2
}

# Can peek after a pop and push
expect {
	result = 
		SimpleLinkedList.from_list([])
			.push(1)
			.push(2)
			->expect_peek(2)?
			.pop()?
			->expect_value(2)?
			->expect_peek(1)?
			.push(3)
			.peek()?

	result == 3
}

##
## toList FIFO
##

# Empty linked list to list is empty
expect {
	result = 
		SimpleLinkedList.from_list([])
			.to_list()

	result == []
}

# To list with multiple values
expect {
	result = 
		SimpleLinkedList.from_list([1, 2, 3])
			.to_list()

	result == [1, 2, 3]
}

# To list after a pop
expect {
	result = 
		SimpleLinkedList.from_list([])
			.push(1)
			.push(2)
			.push(3)
			.pop()?
			->expect_value(3)?
			.push(4)
			.to_list()

	result == [1, 2, 4]
}

##
## reverse
##

# Reversed empty list has same values
expect {
	result = 
		SimpleLinkedList.from_list([])
			.reverse()
			.to_list()

	result == []
}

# Reversed singleton list is same list
expect {
	result = 
		SimpleLinkedList.from_list([1])
			.reverse()
			.to_list()

	result == [1]
}

# Reversed non-empty list is reversed
expect {
	result = 
		SimpleLinkedList.from_list([1, 2, 3])
			.reverse()
			->expect_len(3)?
			.pop()?
			->expect_value(1)?
			.pop()?
			->expect_value(2)?
			.pop()?
			.value

	result == 3
}

# Double reverse
expect {
	result = 
		SimpleLinkedList.from_list([1, 2, 3])
			.reverse()
			.reverse()
			.pop()?
			->expect_value(3)?
			.pop()?
			->expect_value(2)?
			.pop()?
			.value

	result == 1
}

expect_value : { updated_list : SimpleLinkedList, value : U64 }, U64 -> Try(SimpleLinkedList, [UnexpectedValue(U64)])
expect_value = |{ updated_list, value }, expected_value| {
	if value == expected_value Ok(updated_list) else Err(UnexpectedValue(value))
}

expect_len : SimpleLinkedList, U64 -> Try(SimpleLinkedList, [UnexpectedLen(U64)])
expect_len = |list, expected_len| {
	actual_len = list.len()
	if actual_len == expected_len Ok(list) else Err(UnexpectedLen(actual_len))
}

expect_peek : SimpleLinkedList, U64 -> Try(SimpleLinkedList, [UnexpectedPeek(U64), LinkedListWasEmpty])
expect_peek = |list, expected_peek| {
	match list.peek() {
		Ok(actual_peek) => if actual_peek == expected_peek Ok(list) else Err(UnexpectedPeek(actual_peek))
		Err(LinkedListWasEmpty) => Err(LinkedListWasEmpty)
	}
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
