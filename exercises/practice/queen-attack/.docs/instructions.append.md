# Instructions append

## Implementation

In Chess, rows are called "ranks", and columns are called "files".
Ranks range from 1 to 8, while files range from A to H.

In this exercise, `Square` is an opaque type which represents a square on a chessboard.
It uses 0-indexed `row` and `column` fields internally, and it guarantees that they are always valid (i.e., from 0 to 7).

The `create` function takes a `Str` as input, representing a valid square on the chessboard using the official notation, such as `"C5"`.
The `create` function must parse this `Str`, verify that it represents a valid square, and if so it must return a `Square` value containing the appropriate `row` and `column` fields.
Rank 1 corresponds to row 0, and rank 8 corresponds to row 7.
For example, `create("C5")` must return a square with row 4 and column 2.

The `Square` type also exposes handy `rank` and `file` methods.
In the example above, `rank` must return the integer `5`, and `file` must return the character `'C'`.

Lastly, the `queen_can_attack` function takes two different `Square` values and checks whether or not queens placed on these squares can attack each other.

Take-away: opaque types such as `Square` are great when you want to offer some guarantees, such as the fact that `row` and `column` are always between 0 and 7.
Opaque types also hide implementation details from the users, which makes the API cleaner.
