# Instructions Append

## Hints

<details>
<summary>Show hints</summary>

Implement pure functions that return JSON strings; you do not need to run a web server.
Roc provides `Json.parse` and `Json.to_str` as built-ins.
A type annotation on a parsing helper's return value tells `Json.parse` which record structure to decode.
The `payload ?: Str` field is optional: the `payload` bound by the stub's record pattern is either `Ok(text)` or `Err(MissingField)`.

</details>
