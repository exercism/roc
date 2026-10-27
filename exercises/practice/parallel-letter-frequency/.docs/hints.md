# Hints

## General

- The [Unicode library](https://github.com/roc-lang/unicode) provides case conversion and letter detection.
  Look at `unicode.Case.to_lower`, `unicode.GeneralCategory.of_scalar`, `unicode.Scalar.iter`, and `unicode.Scalar.to_str`.

- If your pure task returns a `Try`, `Parallel.map!` returns those task results inside its own `Try`; handle both the platform error and any per-task errors.
