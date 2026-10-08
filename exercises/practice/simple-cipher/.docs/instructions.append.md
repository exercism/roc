# Instructions Append

## Random library

The [`roc-random` package](https://github.com/kili-ilo/roc-random) is available in the header of `simple-cipher-test.roc` (with alias `random`).
You can use it in your solution if you want, for example by importing `random.Random`.

## Hints

<details>
<summary>Show hints</summary>

`Random.step(state, generator)` returns `{ value, state }`, containing a generated value and the updated random state.
Return that updated state from `create_random` so the next call can continue the sequence.
`Random.list` and `Random.map` can help build a generator for a whole key.

</details>
