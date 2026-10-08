# Instructions Append

## Hints

<details>
<summary>Show hints</summary>

`FamilyTree.(family_tree)` in the stub unwraps the nominal type, giving you the underlying `Dict(Str, List(Str))`.
`Dict.to_list` exposes its entries as `(parent, children)` tuples.
A `Set(Str)` can help you avoid revisiting people while exploring relationships.

</details>
