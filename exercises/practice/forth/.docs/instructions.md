# Instructions

Implement an evaluator for a very simple subset of [Forth][forth], a stack-based programming language.

Each program is a series of operations that manipulate a single stack. Your interpreter will need to support the following operations:

Stack manipulation:

- `DUP` - duplicate the top element
- `DROP` - remove the top element
- `SWAP` - swap the top two elements
- `OVER` - copy the second from top element to the top

Integer arithmetic

- `+`
- `-`
- `*`
- `/`

If there are not enough elements on the stack for a function to operate on, your interpreter should return an error.

Your evaluator also has to support defining new words using the customary syntax: `: word-name definition ;`. Each program consists of zero or more definitions followed by one line of instructions.

To keep things simple the only data type you need to support is signed integers of at least 16 bits size.

You should use the following rules for the syntax: a number is a sequence of one or more (ASCII) digits (optionally preceeded with a dash), a word is a sequence of one or more letters, digits, symbols or punctuation that is not a number.
(Forth probably uses slightly different rules, but this is close enough.) Words are case-insensitive.

[forth]: https://en.wikipedia.org/wiki/Forth_%28programming_language%29
