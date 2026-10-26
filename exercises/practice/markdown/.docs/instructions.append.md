# Instructions Append

## Refactoring

The implementation in `Markdown.roc` already passes the tests.
Refactor it while preserving its behavior and the `parse : Str -> Try(Str, _)` interface.
Return `Ok(html)` on success and propagate any parsing errors with `Err(...)`.
This exercise covers a small Markdown subset, not the full Markdown specification.
The tests define the behavior to preserve, including how blank lines and unmatched emphasis markers are handled.

## Hints

<details>
<summary>Show hints</summary>

Look for repeated logic, deeply nested conditions, cryptic names, and unnecessary mutable state.
Consider separating line classification, inline emphasis, and HTML rendering.
The [`roc-parser` package](https://github.com/lukewilliamboswell/roc-parser) is available as `parser` in the test app if you want to use it.
`Parser.one_of`, `Parser.many`, and `Parser.between` can help combine small parsers.
A solution using ordinary string and list functions is equally welcome.

</details>
