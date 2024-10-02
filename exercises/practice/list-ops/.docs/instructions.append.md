# Wait, It's Impossible!

Implementing these list operations without using _any_ built-in function is
virtually impossible in Roc, because you need a way to append or prepend
elements to a list. In other languages you might use operators such as `:`
in Haskell or `+=` in Python, but in Roc you have to use the
[`List` functions](https://www.roc-lang.org/builtins/List).

So for this exercise you're allowed to use `List.append` (but avoid using any
other built-in function).

Many functional programming languages use linked lists as the primary collection type.
It is efficient to prepend an element or pop the first element from a linked list, so in those languages, you would implement list operations
using `List.prepend`. In Roc however, a `List` is an array (a contiguous chunk of bytes). Arrays have different
properties than linked lists like the ability to efficiently access elements by index and append new elements.
Because of this, in Roc we use `List.append` often and rarely use `List.prepend`.

Hint: try using:

```roc
when list is
    [] -> ????
    [first, .. as rest] -> ???
```

or

```roc
when list is
    [] -> ???
    [.. as rest, last] -> ???
```
