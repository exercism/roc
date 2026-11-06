# Instructions Append

## Counting letters in parallel

Count letters, ignoring case and nonletters, and return a dictionary from lowercase letters to their counts.
Treat letters as Unicode scalar values; Unicode normalization is not required.

Use `pf.Parallel.map!(items, { workers, task })` from the [roc-parallel platform](https://github.com/ageron/roc-parallel) to process the given `items` using a pure `task` function, in parallel across multiple threads (given by `workers`).
The results are returned in the input order once all items have been processed.
You only need to edit `ParallelLetterFrequency.roc`.

## Running the tests

Unlike most other exercises, this exercise uses effectful functions.
Run the tests with `roc --opt=speed parallel-letter-frequency-test.roc`, rather than `roc test`.
Any error returned by the Roc code is reported by the platform, using a different format than usual.

You may also want to check out the [bank-account exercise](https://exercism.org/tracks/roc/exercises/bank-account), which explores a different side of concurrency: applying updates safely to shared state.
