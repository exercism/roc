# Instructions Append

## Tree operations

`from_pov` returns the tree from the point of view of the node with the given label, or `Err(NotFound)` if no such node exists.

`path_to` returns the labels of the nodes between the two given nodes, or `Err(NotFound)` if either node does not exist.

The stub enables default equality with `is_eq` and hashing with `to_hash`.
Hashing allows trees to be stored in a `Set`.
