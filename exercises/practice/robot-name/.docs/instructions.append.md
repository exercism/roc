# Instructions Append

## Factories and robots

A `Factory` creates robots and holds state such as existing robot names and the current random state.

A `Robot` must either have no name or have a name composed of two letters followed by three digits.

## The `roc-random` package

The [`roc-random` package](https://github.com/kili-ilo/roc-random) is available in the header of `robot-name-test.roc` (with alias `random`).
You can use it in your solution if you want, for example by importing `random.Random`.

## Hints

<details>
<summary>Show hints</summary>

Robot and factory operations return new values rather than modifying their arguments.
Use a robot's `get_factory()` result when creating the next robot so that it sees the updated names and random state.
`Random.step(state, generator)` returns both a value and an updated state.
Keep advancing that state when retrying a name collision, otherwise you may generate the same name repeatedly.

</details>
