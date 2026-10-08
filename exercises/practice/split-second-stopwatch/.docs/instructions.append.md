# Instructions Append

## Pros and cons of `from_quote`

The `Time.from_quote` function parses a string formatted as `"HH:MM:SS"` into a `Time`.
This makes it possible to write code such as this:

```roc
time : Time
time = "00:01:23"
```

This code implicitly calls `Time.from_quote("00:01:23")` at compile time.
This can potentially speed up the program since it doesn't need to handle parsing at runtime, and it ensures that times rejected by `from_quote` are caught at compile time, rather than at runtime.
Moreover, it makes the code nice and readable.
For example, here's one of the tests in this exercise:

```roc
## start initiates time tracking for current lap
expect {
	result = Stopwatch.create()
		.start()?
		.advance_time("00:00:05")
		|> expect_current_lap("00:00:05")

	result.is_ok()
}
```

However, someone reading this code might assume that the `advance_time` function takes a `Str` when in fact it takes a `Time`.
This can lead to confusion and errors.
For this reason, you may prefer the slightly longer but more explicit format: `"00:00:05".Time` which also calls `from_quote` at compile time.

In your own programs, you may prefer to use `from_str` instead:

```roc
Time := { ... }.{
    from_str : Str -> Try(Time, [InvalidTime])
    from_str = |time_str| ...
}
```

You can also call `from_str` (or any other pure function) at compile time, like this:

```roc
Ok(time) = Time.from_str("00:01:23")
```

Note: Placing this definition at the top level makes it run at compile time (since the function is pure and its input is known at compile time).
Inside a function, you can use `from_str` at runtime.

## Hints

<details>
<summary>Show hints</summary>

Operations return an updated stopwatch rather than modifying their argument.
Record updates such as `{ ..stopwatch, state: Running }` preserve the other fields.
`advance_time` receives an elapsed duration from the tests, so you do not need a clock or platform effects.
Widen `U8` minutes and seconds before arithmetic that might exceed their range.

</details>
