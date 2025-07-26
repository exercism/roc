# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/forth/canonical-data.json
# File last updated on 2025-07-26
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Forth exposing [evaluate]

# parsing and numbers: numbers just get pushed onto the stack
expect
    result = evaluate("1 2 3 4 5")
    result == Ok([1, 2, 3, 4, 5])

# parsing and numbers: pushes negative numbers onto the stack
expect
    result = evaluate("-1 -2 -3 -4 -5")
    result == Ok([-1, -2, -3, -4, -5])

# addition: can add two numbers
expect
    result = evaluate("1 2 +")
    result == Ok([3])

# addition: errors if there is nothing on the stack
expect
    result = evaluate("+")
    Result.is_err(result)

# addition: errors if there is only one value on the stack
expect
    result = evaluate("1 +")
    Result.is_err(result)

# addition: more than two values on the stack
expect
    result = evaluate("1 2 3 +")
    result == Ok([1, 5])

# subtraction: can subtract two numbers
expect
    result = evaluate("3 4 -")
    result == Ok([-1])

# subtraction: errors if there is nothing on the stack
expect
    result = evaluate("-")
    Result.is_err(result)

# subtraction: errors if there is only one value on the stack
expect
    result = evaluate("1 -")
    Result.is_err(result)

# subtraction: more than two values on the stack
expect
    result = evaluate("1 12 3 -")
    result == Ok([1, 9])

# multiplication: can multiply two numbers
expect
    result = evaluate("2 4 *")
    result == Ok([8])

# multiplication: errors if there is nothing on the stack
expect
    result = evaluate("*")
    Result.is_err(result)

# multiplication: errors if there is only one value on the stack
expect
    result = evaluate("1 *")
    Result.is_err(result)

# multiplication: more than two values on the stack
expect
    result = evaluate("1 2 3 *")
    result == Ok([1, 6])

# division: can divide two numbers
expect
    result = evaluate("12 3 /")
    result == Ok([4])

# division: performs integer division
expect
    result = evaluate("8 3 /")
    result == Ok([2])

# division: errors if dividing by zero
expect
    result = evaluate("4 0 /")
    Result.is_err(result)

# division: errors if there is nothing on the stack
expect
    result = evaluate("/")
    Result.is_err(result)

# division: errors if there is only one value on the stack
expect
    result = evaluate("1 /")
    Result.is_err(result)

# division: more than two values on the stack
expect
    result = evaluate("1 12 3 /")
    result == Ok([1, 4])

# combined arithmetic: addition and subtraction
expect
    result = evaluate("1 2 + 4 -")
    result == Ok([-1])

# combined arithmetic: multiplication and division
expect
    result = evaluate("2 4 * 3 /")
    result == Ok([2])

# combined arithmetic: multiplication and addition
expect
    result = evaluate("1 3 4 * +")
    result == Ok([13])

# combined arithmetic: addition and multiplication
expect
    result = evaluate("1 3 4 + *")
    result == Ok([7])

# dup: copies a value on the stack
expect
    result = evaluate("1 dup")
    result == Ok([1, 1])

# dup: copies the top value on the stack
expect
    result = evaluate("1 2 dup")
    result == Ok([1, 2, 2])

# dup: errors if there is nothing on the stack
expect
    result = evaluate("dup")
    Result.is_err(result)

# drop: removes the top value on the stack if it is the only one
expect
    result = evaluate("1 drop")
    result == Ok([])

# drop: removes the top value on the stack if it is not the only one
expect
    result = evaluate("1 2 drop")
    result == Ok([1])

# drop: errors if there is nothing on the stack
expect
    result = evaluate("drop")
    Result.is_err(result)

# swap: swaps the top two values on the stack if they are the only ones
expect
    result = evaluate("1 2 swap")
    result == Ok([2, 1])

# swap: swaps the top two values on the stack if they are not the only ones
expect
    result = evaluate("1 2 3 swap")
    result == Ok([1, 3, 2])

# swap: errors if there is nothing on the stack
expect
    result = evaluate("swap")
    Result.is_err(result)

# swap: errors if there is only one value on the stack
expect
    result = evaluate("1 swap")
    Result.is_err(result)

# over: copies the second element if there are only two
expect
    result = evaluate("1 2 over")
    result == Ok([1, 2, 1])

# over: copies the second element if there are more than two
expect
    result = evaluate("1 2 3 over")
    result == Ok([1, 2, 3, 2])

# over: errors if there is nothing on the stack
expect
    result = evaluate("over")
    Result.is_err(result)

# over: errors if there is only one value on the stack
expect
    result = evaluate("1 over")
    Result.is_err(result)

# user-defined words: can consist of built-in words
expect
    result = evaluate(
        """
        : dup-twice dup dup ;
        1 dup-twice
        """,
    )
    result == Ok([1, 1, 1])

# user-defined words: execute in the right order
expect
    result = evaluate(
        """
        : countup 1 2 3 ;
        countup
        """,
    )
    result == Ok([1, 2, 3])

# user-defined words: can override other user-defined words
expect
    result = evaluate(
        """
        : foo dup ;
        : foo dup dup ;
        1 foo
        """,
    )
    result == Ok([1, 1, 1])

# user-defined words: can override built-in words
expect
    result = evaluate(
        """
        : swap dup ;
        1 swap
        """,
    )
    result == Ok([1, 1])

# user-defined words: can override built-in operators
expect
    result = evaluate(
        """
        : + * ;
        3 4 +
        """,
    )
    result == Ok([12])

# user-defined words: can use different words with the same name
expect
    result = evaluate(
        """
        : foo 5 ;
        : bar foo ;
        : foo 6 ;
        bar foo
        """,
    )
    result == Ok([5, 6])

# user-defined words: can define word that uses word with the same name
expect
    result = evaluate(
        """
        : foo 10 ;
        : foo foo 1 + ;
        foo
        """,
    )
    result == Ok([11])

# user-defined words: errors if executing a non-existent word
expect
    result = evaluate("foo")
    Result.is_err(result)

# case-insensitivity: DUP is case-insensitive
expect
    result = evaluate("1 DUP Dup dup")
    result == Ok([1, 1, 1, 1])

# case-insensitivity: DROP is case-insensitive
expect
    result = evaluate("1 2 3 4 DROP Drop drop")
    result == Ok([1])

# case-insensitivity: SWAP is case-insensitive
expect
    result = evaluate("1 2 SWAP 3 Swap 4 swap")
    result == Ok([2, 3, 4, 1])

# case-insensitivity: OVER is case-insensitive
expect
    result = evaluate("1 2 OVER Over over")
    result == Ok([1, 2, 1, 2, 1])

# case-insensitivity: user-defined words are case-insensitive
expect
    result = evaluate(
        """
        : foo dup ;
        1 FOO Foo foo
        """,
    )
    result == Ok([1, 1, 1, 1])

# case-insensitivity: definitions are case-insensitive
expect
    result = evaluate(
        """
        : SWAP DUP Dup dup ;
        1 swap
        """,
    )
    result == Ok([1, 1, 1, 1])

