# Hints

## General

- In `Tree`, `left ?: Tree` and `right ?: Tree` declare optional fields.
  Access one with `tree.?left`, which returns `Ok(child)` or `Err(MissingField)`.

- Use `{ ..tree, left: child }` to set it and `{ ..tree, left: _ }` to remove it.
  These expressions produce updated trees; they do not modify the original tree.
