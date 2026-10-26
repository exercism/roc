# Hints

## General

- The [`roc-random` package](https://github.com/kili-ilo/roc-random) is available in the header of `robot-name-test.roc` (with alias `random`).
  You can use it in your solution if you want, for example by importing `random.Random`.

- Robot and factory operations return new values rather than modifying their arguments.
  Use a robot's `get_factory()` result when creating the next robot so that it sees the updated names and random state.

- `Random.step(state, generator)` returns both a value and an updated state.
  Keep advancing that state when retrying a name collision, otherwise you may generate the same name repeatedly.
