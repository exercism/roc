# Hints

## General

- The [`roc-random` package](https://github.com/kili-ilo/roc-random) is available with the alias `random` in the test app.
  The stub imports `random.Random`.

- A `Random.Generator(a)` describes how to generate a value of type `a`.

- Use `Random.list` to combine draws and `Random.map` to transform their results.

- `Random.step(state, generator)` returns `{ value, state }`; carry the updated state between simulated groups so you do not repeat the same sample.
