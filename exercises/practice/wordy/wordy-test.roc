# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/wordy/canonical-data.json
# File last updated on 2025-07-26
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Wordy exposing [answer]

# just a number
expect
    result = answer("What is 5?")
    result == Ok(5)

# just a zero
expect
    result = answer("What is 0?")
    result == Ok(0)

# just a negative number
expect
    result = answer("What is -123?")
    result == Ok(-123)

# addition
expect
    result = answer("What is 1 plus 1?")
    result == Ok(2)

# addition with a left hand zero
expect
    result = answer("What is 0 plus 2?")
    result == Ok(2)

# addition with a right hand zero
expect
    result = answer("What is 3 plus 0?")
    result == Ok(3)

# more addition
expect
    result = answer("What is 53 plus 2?")
    result == Ok(55)

# addition with negative numbers
expect
    result = answer("What is -1 plus -10?")
    result == Ok(-11)

# large addition
expect
    result = answer("What is 123 plus 45678?")
    result == Ok(45801)

# subtraction
expect
    result = answer("What is 4 minus -12?")
    result == Ok(16)

# multiplication
expect
    result = answer("What is -3 multiplied by 25?")
    result == Ok(-75)

# division
expect
    result = answer("What is 33 divided by -3?")
    result == Ok(-11)

# multiple additions
expect
    result = answer("What is 1 plus 1 plus 1?")
    result == Ok(3)

# addition and subtraction
expect
    result = answer("What is 1 plus 5 minus -2?")
    result == Ok(8)

# multiple subtraction
expect
    result = answer("What is 20 minus 4 minus 13?")
    result == Ok(3)

# subtraction then addition
expect
    result = answer("What is 17 minus 6 plus 3?")
    result == Ok(14)

# multiple multiplication
expect
    result = answer("What is 2 multiplied by -2 multiplied by 3?")
    result == Ok(-12)

# addition and multiplication
expect
    result = answer("What is -3 plus 7 multiplied by -2?")
    result == Ok(-8)

# multiple division
expect
    result = answer("What is -12 divided by 2 divided by -3?")
    result == Ok(2)

# unknown operation
expect
    result = answer("What is 52 cubed?")
    Result.is_err(result)

# Non math question
expect
    result = answer("Who is the President of the United States?")
    Result.is_err(result)

# reject problem missing an operand
expect
    result = answer("What is 1 plus?")
    Result.is_err(result)

# reject problem with no operands or operators
expect
    result = answer("What is?")
    Result.is_err(result)

# reject two operations in a row
expect
    result = answer("What is 1 plus plus 2?")
    Result.is_err(result)

# reject two numbers in a row
expect
    result = answer("What is 1 plus 2 1?")
    Result.is_err(result)

# reject postfix notation
expect
    result = answer("What is 1 2 plus?")
    Result.is_err(result)

# reject prefix notation
expect
    result = answer("What is plus 1 2?")
    Result.is_err(result)

