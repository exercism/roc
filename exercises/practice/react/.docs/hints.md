# Hints

## General

- You can store functions in records alongside their cell or callback identifiers.

- To call a function stored in a record field, use parentheses, as in `(cell.compute)(values)` or `(registration.callback)(value, log)`.
  Without those parentheses, Roc treats the call as a method on the record's type.

- `List.map_try` and `List.fold_try` can help sequence computations that may fail.
