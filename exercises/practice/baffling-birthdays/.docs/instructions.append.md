# Instructions append

## Pros and cons of `from_quote`
This exercise defines a `from_quote` function in the `DateOfBirth` type. This makes it possible to write code such as this:

```roc
birthdate : DateOfBirth
birthdate = "2019-01-20"
```

This code implicitly calls `DateOfBirth.from_quote("2019-01-20")` at compile time. This can potentially speed up the program since it doesn't need to handle parsing at runtime, and it ensures that dates rejected by `from_quote` are caught at compile time, rather than at runtime. Moreover, it makes the code nice and readable. For example, here's one of the tests in this exercise:

```roc
# multiple birthdates with one shared birthday
expect {
	shared_birthday(["1966-07-29", "1977-02-12", "2001-07-29", "1980-11-10"])
}
```

However, someone reading this code might assume that the `shared_birthday` function takes a `List(Str)`, when in fact it takes a `List(DateOfBirth)`. This can lead to confusion and errors. For this reason, you may prefer the slightly longer but more explicit format: `"2019-01-20".DateOfBirth` which also calls `from_quote` at compile time.

In your own programs, you may prefer to provide a convenient constructor, such as this one:

```roc
DateOfBirth := { year : I64, month : U8, day : U8 }.{
    from_ymd : I64, U8, U8 -> Try(DateOfBirth, [InvalidMonth, InvalidDay])
    from_ymd = |year, month, day| ...
}
```

You can also call this constructor at compile time, like this:

```roc
Ok(birthdate) = DateOfBirth.from_ymd(2019, 1, 20)
```

Note: Placing this definition at the top level makes it run at compile time (since the function is pure and the inputs are known at compile time). Inside a function, you can use the same constructor at runtime.
