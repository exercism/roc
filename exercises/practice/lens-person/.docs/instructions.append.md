# Instructions append

Lenses are not used much in Roc because the record update syntax covers most use cases nicely. For example, consider this nested record:

```roc
bob = { hair: { color: Brown, length: Long }, mouth: Smiling, height: 6.0 }
```

Now let's give Bob a haircut:

```roc
new_bob = { ..bob, hair: { ..bob.hair, length: Short } }
```

No lenses needed! That said, even though lenses are rare in Roc, they are common in other languages like Haskell and Scala, so you might be curious to know how one might implement them in Roc. It's also a good way to practice some advanced Roc features such as parameterized types, and records containing functions. Indeed, here is one way to represent a lens in Roc:

```roc
Lens(whole, part) := {
	get : whole -> part,
	set : whole, part -> whole,
}
```

This is a parameterized type: `whole` and `part` could be any types. `whole` is typically a record, while `part` can be any field type. The `get` field contains a function that returns a specific `part` of the given `whole`, while the `set` field contains a function that returns a copy of the given `whole`, except with a specific `part` replaced by the given `part`.

For example, here's a lens to get or set a person's hair:

```roc
hair_lens = {
	get: |person| person.hair,
	set: |person, hair| { ..person, hair },
}
```

We can use this lens to focus on Bob's hair, like this:

```roc
bob_hair = bob |> hair_lens.get
```

And we can change his hair like this:

```roc
new_hair = { ..bob.hair, length: Short }
new_bob = bob |> (hair_lens.set)(new_hair)
```

Note: the parentheses around `hair_lens.set` are required: without them, Roc would look for a function named `set` in `hair_lens`'s type.

Lenses become especially useful when you start composing them, letting you get and set deeply nested parts. This can be done by implementing a function like this:

```roc
compose : Lens(outer, inner), Lens(inner, part) -> Lens(outer, part)
```

Once this function is implemented, you can use it to create a hair-length lens like this:

```roc
length_lens = {
	get: |hair| hair.length,
	set: |hair, length| { ..hair, length },
}
hair_length_lens = compose(hair_lens, length_lens)

```

Now you can give Bob another haircut:

```roc
set_hair_length = hair_length_lens.set
new_bob = bob |> set_hair_length(Short)
```

You may also want to implement a function that lets you apply any transformation to a nested part:

```roc
over : Lens(whole, part), whole, (part -> part) -> whole
```

Once implemented, you can use `over` like this:

```roc
cut_hair = |current_length| match current_length {
	Long => Short
	Short => Bald
	Bald => Bald
}
new_bob = hair_length_lens |> over(bob, cut_hair)
```

In this exercise, the tests will check that your code is able to modify various nested parts of the following nested record:

```roc
test_person : Person
test_person = {
	name: { forenames: "Jane Joanna", surname: "Doe" },
	birth: {
		born_at: { street: "Longway", house_number: 1024, place: "Springfield", country: "United States" },
		born_on: { year: 1984, month: 4, day: 12 },
	},
	address: { street: "Shortlane", house_number: 2, place: "Fallmeadow", country: "Canada" },
}
```

We recommend you first pass the tests using Roc's record update syntax, then try using lenses instead.
