# Instructions append

## Pros and cons of `from_quote`
This exercise defines a `from_quote` function in the `Card` type. This makes it possible to write code such as this:

```roc
card : Card
card = "Q"
```

This code implicitly calls `Card.from_quote("Q")` at compile time. This can potentially speed up the program since it doesn't need to handle parsing at runtime, and it ensures that cards rejected by `from_quote` are caught at compile time, rather than at runtime. Moreover, it makes the code nice and readable. For example, here's one of the tests in this exercise:

```roc
result = simulate_game({
    player_a: ["2", "A"],
    player_b: ["3", "4", "5", "6", "K"],
})
```

However, someone reading this code might assume that the `simulate_game` function takes a record containing two `List(Str)`, when in fact it's a record containing two `List(Card)`. This can lead to confusion and errors. For this reason, you may prefer the slightly longer but more explicit format: `"Q".Card` which also calls `from_quote` at compile time.

In your own programs, you may prefer to use `from_str` instead:

```roc
Card := { ... }.{
    from_str : card_str -> Try(Card, [InvalidCard])
    from_str = |card_str| ...
}
```

You can also call `from_str` (or any other pure function) at compile time, like this:

```roc
Ok(card) = Card.from_str("Q")
```

Note: Placing this definition at the top level makes it run at compile time (since the function is pure and its input is known at compile time). Inside a function, you can use `from_str` at runtime.
