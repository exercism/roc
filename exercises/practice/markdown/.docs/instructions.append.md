# Instructions Append

## Refactoring Markdown parsing

The implementation in `Markdown.roc` already passes the tests.
Refactor it while preserving its behavior and the `parse : Str -> Try(Str, _)` interface.
Return `Ok(html)` on success and propagate any parsing errors with `Err(...)`.
This exercise covers a small Markdown subset, not the full Markdown specification.
The tests define the behavior to preserve, including how blank lines and unmatched emphasis markers are handled.
