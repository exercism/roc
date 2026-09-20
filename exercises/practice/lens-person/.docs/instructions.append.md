# Instructions append

On way to represent a lens in Roc is using a record containing two functions:

```roc
Lens(whole, part) := {
    get : whole -> part,
    set : whole, part -> whole,
}
```

The power of lenses becomes clear when you start composing them. This can be done by implementing a function like this:

```roc
compose : Lens(outer, inner), Lens(inner, part) -> Lens(outer, part)
```

You may also want to implement a function that lets you apply any transformation to a nested field:

```roc
over : Lens(whole, part), whole, (part -> part) -> whole
```

Hints:
* Define `compose` inside `Lens` to allow chains such as `birth.compose(born_at).compose(street)`.
* Add an `over` method that uses the getter and setter to transform the focused value: `lens.over(value, transform)`.
* Pipelines can call functions stored in record fields: `whole |> outer.get |> inner.get`.
