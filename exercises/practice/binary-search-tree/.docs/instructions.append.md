# Instructions Append

## Hints

<details>
<summary>Show hints</summary>

The supplied type is recursive: `Nil` represents an empty tree, and `Node(node)` contains a record with a value and two subtrees.
A `match` can distinguish these cases and bind the node record.
Record updates such as `{ ..node, left: new_left }` preserve the other fields; wrap the updated record in `Node(...)` to construct the resulting tree.

</details>
