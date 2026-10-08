# Instructions Append

## Roc types and operations

A `Zipper` lets you traverse and update a binary `Tree`, where each node holds an integer.

- `Tree.to_zipper`: create a zipper focused on the tree's root node.
- `to_tree`: get the tree out of the zipper.
- `value`: get the value of the focused node.
- `left` and `right`: move the focus to the current node's left or right child, returning a new zipper.
- `up`: move the focus to the parent, returning a new zipper.
- `set_value`: set the focused node's value, returning a new zipper.
- `set_left` and `set_right`: replace the left or right child, returning a new zipper.
- `remove_left` and `remove_right`: remove the left or right child, returning a new zipper.

## Hints

<details>
<summary>Show hints</summary>

In `Tree`, `left ?: Tree` and `right ?: Tree` declare optional fields.
Access one with `tree.?left`, which returns `Ok(child)` or `Err(MissingField)`.
Use `{ ..tree, left: child }` to set it and `{ ..tree, left: _ }` to remove it.
These expressions produce updated trees; they do not modify the original tree.

</details>
