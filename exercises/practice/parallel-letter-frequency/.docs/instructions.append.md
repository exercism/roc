# Instructions Append

Count letters, ignoring case and nonletters, and return a dictionary from lowercase letters to their counts.

Use `pf.Parallel.map!(items, { workers, task })` from the [roc-parallel platform](https://github.com/ageron/roc-parallel) to process the given `items` using a pure `task` function, in parallel across multiple threads (given by `workers`). The results are returned in the input order once all items have been processed. You only need to edit `ParallelLetterFrequency.roc`.

Hint: We recommend you use the [Unicode library](https://github.com/roc-lang/unicode) for case conversion and letter detection. In particular, check out `unicode.Case.to_lower`, `unicode.GeneralCategory.of_scalar`, `unicode.Scalar.iter`, and `unicode.Scalar.to_str`. Treat letters as Unicode scalar values; Unicode normalization is not required.

Note: Unlike most other exercises, this exercise uses effectful functions. For now, Roc's `expect` statement cannot call effectful functions, so in this exercise the tests don't use `expect` or `roc test` at all. Instead, the tests are run using `roc --opt=speed` and any error returned by the Roc code is reported by the platform, using a different format than usual.

You may also want to check out the `bank-account` exercise, which explores a different side of concurrency: applying updates safely to shared state.
