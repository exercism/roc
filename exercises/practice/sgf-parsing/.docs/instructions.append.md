# Instructions Append

## The `roc-parser` Package

We added the `roc-parser` package to the app's header in `sgf-parsing-test.roc` (with alias `parser`), so you can use it if you want—particularly the `parser.Parser` module, and perhaps the `parser.Utf8` module as well.
However, if you prefer to roll out your own solution from scratch, that's fine too!

## Hints

<details>
<summary>Show hints</summary>

If you use `roc-parser`, build small parsers and combine them.
For example, `Utf8.codeunit('A').one_or_more()` parses one or more occurrences of the byte `'A'`.
Use `keep` for a result you need and `skip` for punctuation you want to discard.
For a recursive grammar, `Parser.lazy(|_| another_parser)` delays looking up the nested parser.

</details>
