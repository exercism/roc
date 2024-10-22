# File last updated on 2024-10-22
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import SimpleLinkedList exposing [fromList, toList, push, pop, reverse, len]

# can create an empty linked list
expect
    result = [] |> fromList |> toList
    expected = []
    result == expected

# can create a linked list with a single element
expect
    result = [123] |> fromList |> toList
    expected = [123]
    result == expected

# can create a linked list with multiple elements
expect
    result = [123, 456, 789] |> fromList |> toList
    expected = [123, 456, 789]
    result == expected

# can push items to a linked list
expect
    result = [123] |> fromList |> push 456 |> push 789 |> toList
    expected = [123, 456, 789]
    result == expected

# can pop an item from a linked list
expect
    popResult = [123, 456, 789] |> fromList |> pop
    result = popResult |> Result.try \popped -> Ok popped.value
    expected = Ok 789
    result == expected

# the last element should be gone after pop
expect
    popResult = [123, 456, 789] |> fromList |> pop
    result = popResult |> Result.try \popped -> Ok (popped.linkedList |> toList)
    expected = Ok [123, 456]
    result == expected

# cannot pop an empty linked list
expect
    result = [] |> fromList |> pop
    result |> Result.isErr

# can reverse a linked list
expect
    result = [123, 456, 789] |> fromList |> reverse |> toList
    expected = [789, 456, 123]
    result == expected

# can reverse an empty linked list and it's still empty
expect
    result = [] |> fromList |> reverse |> toList
    expected = []
    result == expected

# can get the length of a linked list
expect
    result = [123, 456, 789] |> fromList |> len
    expected = 3
    result == expected

# can get the length of an empty linked list
expect
    result = [] |> fromList |> len
    expected = 0
    result == expected
