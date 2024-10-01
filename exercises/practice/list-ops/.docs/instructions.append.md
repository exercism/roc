# Wait, It's Impossible!
Implementing these list operations without using *any* built-in function is
virtually impossible in Roc, because you need a way to append or prepend
elements to a list. In other languages you might use operators such as `:`
in Haskell or `+=` in Python, but in Roc you have to use the
[`List` functions](https://www.roc-lang.org/builtins/List).

So for this exercise you're allowed to use `List.append` (but avoid using any
other built-in function).

In many functional programming languages, lists are implemented as linked lists.
With linked list, it is easy to prepend elements to a list or pop the first
element from a list.  In those languages, you would implement list operation
with `List.prepend`. But in Roc, a `List` is an array. An array has different
properties then a linked list. It is relativly easy to append elements and no
problem at all to get an element by index. So in Roc, we use `List.append`
often, and try never to use `List.prepend`.

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