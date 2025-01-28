# File last updated on 2025-1-4
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import SimpleLinkedList exposing [from_list, to_list, push, pop, reverse, len]

# can create an empty linked list
expect
    result = [] |> from_list |> to_list
    expected = []
    result == expected

# can create a linked list with a single element
expect
    result = [123] |> from_list |> to_list
    expected = [123]
    result == expected

# can create a linked list with multiple elements
expect
    result = [123, 456, 789] |> from_list |> to_list
    expected = [123, 456, 789]
    result == expected

# can push items to a linked list
expect
    result = [123] |> from_list |> push(456) |> push(789) |> to_list
    expected = [123, 456, 789]
    result == expected

# can pop an item from a linked list
expect
    pop_result = [123, 456, 789] |> from_list |> pop
    result = pop_result |> Result.try(|popped| Ok(popped.value))
    expected = Ok(789)
    result == expected

# the last element should be gone after pop
expect
    pop_result = [123, 456, 789] |> from_list |> pop
    result = pop_result |> Result.try(|popped| Ok((popped.linked_list |> to_list)))
    expected = Ok([123, 456])
    result == expected

# cannot pop an empty linked list
expect
    result = [] |> from_list |> pop
    result |> Result.is_err

# can reverse a linked list
expect
    result = [123, 456, 789] |> from_list |> reverse |> to_list
    expected = [789, 456, 123]
    result == expected

# can reverse an empty linked list and it's still empty
expect
    result = [] |> from_list |> reverse |> to_list
    expected = []
    result == expected

# can get the length of a linked list
expect
    result = [123, 456, 789] |> from_list |> len
    expected = 3
    result == expected

# can get the length of an empty linked list
expect
    result = [] |> from_list |> len
    expected = 0
    result == expected
