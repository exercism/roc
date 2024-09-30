# Wait, It's Impossible!
Implementing these list operations without using *any* built-in function is
virtually impossible in Roc, because you need a way to append or prepend
elements to a list. In other languages you might use operators such as `:`
in Haskell or `+=` in Python, but in Roc you have to use the
[`List` functions](https://www.roc-lang.org/builtins/List).

So for this exercise you're allowed to use `List.append` (but avoid using any
other built-in function).

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