# Hints

## General

- Look for repeated logic, deeply nested conditions, cryptic names, and unnecessary mutable state.

- Consider separating line classification, inline emphasis, and HTML rendering.

- The [`roc-parser` package](https://github.com/lukewilliamboswell/roc-parser) is available as `parser` in the test app if you want to use it.
  `Parser.one_of`, `Parser.many`, and `Parser.between` can help combine small parsers.
  A solution using ordinary string and list functions is equally welcome.
