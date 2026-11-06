# Hints

## General

- Operations return an updated stopwatch rather than modifying their argument.

- Record updates such as `{ ..stopwatch, state: Running }` preserve the other fields.

- `advance_time` receives an elapsed duration from the tests, so you do not need a clock or platform effects.

- Widen `U8` minutes and seconds before arithmetic that might exceed their range.
