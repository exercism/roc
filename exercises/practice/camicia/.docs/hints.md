# Hints

## General

- Use `match` with `[]` and `[card, .. as rest]` to distinguish an empty deck from its next card and remaining cards.

- Record updates such as `{ ..state, pile: new_pile }` can keep game transitions explicit without mutable state.

- A `Set` can store tuples or lists as keys when tracking previously seen game states.
