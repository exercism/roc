# Instructions Append

## Deque operations

- `empty`: create an empty deque.
- `append`: add a value at the end (often called `push` in other languages).
- `pop_last`: remove the last value and return it with the updated deque, or `Err(DequeWasEmpty)` (often called `pop`).
- `prepend`: add a value at the start (often called `unshift`).
- `pop_first`: remove the first value and return it with the updated deque, or `Err(DequeWasEmpty)` (often called `shift`).
- `remove_value`: remove the first occurrence of a value, leaving the deque unchanged if absent.
- `len`: return the number of values in the deque.
