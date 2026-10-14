# Instructions Append

## Hints

<details>
<summary>Show hints</summary>

Each operation returns an updated buffer rather than modifying the original.
This includes `read`, whose successful result contains both `value` and `updated_buffer`.
Use record updates such as `{ ..buffer, length: 0 }` to preserve the other fields.
`List.replace` returns a `Try` whose successful record contains the updated list in its `list` field.

</details>
