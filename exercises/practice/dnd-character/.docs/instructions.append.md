# Instructions Append

## Random library

The [`roc-random` package](https://github.com/kili-ilo/roc-random) is available in the header of `dnd-character-test.roc` (with alias `random`).
You can use it in your solution, for example by importing `random.Random`.

## Hints

<details>
<summary>Show hints</summary>

A `Random.Generator(a)` describes how to generate a value of type `a`; it is not itself a generated value.
`Random.list` combines repeated draws, and `Random.map` transforms the generated result.
You can combine generators with `Random.map2`, or turn a record of generators into a generator of records using `.Random`.
The tests supply the random seed and run your generators.

</details>
