# Instructions Append

## Hints

<details>
<summary>Show hints</summary>

`NestedValue` is a recursive tag union: each value is `Value(number)`, `Null`, or `NestedArray(children)`.
Use `match` to distinguish these cases and bind their payloads.
`List.join_map` may be useful when a function maps each child to a list and you want to concatenate the results.

</details>
